Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A818F557E52
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 16:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbiFWOzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 10:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiFWOzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 10:55:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1762B3B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 07:55:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A84E12FC;
        Thu, 23 Jun 2022 07:55:45 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5047E3F66F;
        Thu, 23 Jun 2022 07:55:44 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, lukasz.luba@arm.com,
        james.quinlan@broadcom.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 0/2] Add SCMI full message tracing
Date:   Thu, 23 Jun 2022 15:55:31 +0100
Message-Id: <20220623145533.2882688-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

after a few recent troubles handling too strictly out-of-spec replies from
SCMI servers deployed in the wild, I though it could have been useful to
have a basic way to dump at will the effective full payloads of successfuly
transmitted/received SCMI messages.

The existing SCMI traces already collect a bunch of information about SCMI
message exchanges but they do NOT keep any payload information: this is
certainly preferable most of the time since dumping full SCMI messages to
the trace buffer involves a full copy of the payload.

For this reason I added a new distinct trace_scmi_msg_dump with this series
in order to be able to selectively enable at will message dumping only when
required.

Only successfully transmitted and received (valid) xfers are dumped.

At first I was thinking about just dumping raw header and payload, but in
order to make the log a bit more human readable (without the need of
tooling to parse the log), I added some parsing/interpretation of the
header, so that the final result is something like:

root@deb-guest:~# echo 1 > /sys/kernel/debug/tracing/events/scmi/scmi_msg_dump/enable 
root@deb-guest:~# cat /sys/kernel/debug/tracing/trace_pipe 

(my annotations non on traces =>>)			 proto  type  cmd   seq  status    payload
							  |      |    |      |     |        |
 ++ cmd/reply						  |      |    |      |     |        |
   cat-224     [002] .....   147.755847: scmi_msg_dump: [0x15]:CMND:[0x06]:[0021]:[0]: 0000000000000000
<idle>-0       [000] d.h2.   147.758311: scmi_msg_dump: [0x15]:RESP:[0x06]:[0021]:[0]: 25000000000000000000000000000000


 ++ cmd/reply/delayed
   cat-223     [001] .....   122.384192: scmi_msg_dump: [0x15]:CMND:[0x06]:[0020]:[0]: 0100000001000000
<idle>-0       [000] d.h2.   122.405548: scmi_msg_dump: [0x15]:RESP:[0x06]:[0020]:[0]: 
<idle>-0       [000] d.h2.   122.425839: scmi_msg_dump: [0x15]:DLYD:[0x06]:[0020]:[0]: 01000000a05a320000000000efbeaddefecafeca


 ++ enable notif/notif
iio_generic_buf-233     [003] .....   522.399690: scmi_msg_dump: [0x15]:CMND:[0x0A]:[0024]:[0]: 0800000003000000
         <idle>-0       [000] dNh2.   522.417778: scmi_msg_dump: [0x15]:RESP:[0x0A]:[0024]:[0]: 00000000
         <idle>-0       [000] d.h2.   522.500945: scmi_msg_dump: [0x15]:NOTI:[0x01]:[0000]:[0]: 000000000800000008daffffffffffff0040d3a45d46fb1610daffffffffffff0040d3a45d46fb1618daffffffffffff0040d3a45d46fb16

Payload is dumped as it comes through byte-by-byte without any endianity
conversion to avoid further load on the system.

Any thoughs ?

Thanks,
Cristian

Cristian Marussi (2):
  include: trace: Add SCMI full message tracing
  firmware: arm_scmi: Use new SCMI full message tracing

 drivers/firmware/arm_scmi/driver.c | 21 ++++++++++++++++++++
 include/trace/events/scmi.h        | 31 ++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

-- 
2.32.0

