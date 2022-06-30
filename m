Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA848562150
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 19:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236362AbiF3Rb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 13:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbiF3Rbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 13:31:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E52B20BD3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 10:31:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 451B71063;
        Thu, 30 Jun 2022 10:31:52 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDE1A3F792;
        Thu, 30 Jun 2022 10:31:50 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, lukasz.luba@arm.com,
        james.quinlan@broadcom.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v2 0/2] Add SCMI full message tracing
Date:   Thu, 30 Jun 2022 18:31:33 +0100
Message-Id: <20220630173135.2086631-1-cristian.marussi@arm.com>
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
have a basic way to dump at will the effective full payloads of
successfully transmitted/received SCMI messages.

The existing SCMI traces already collect a bunch of information about SCMI
message exchanges but they do NOT keep any payload information: this is
certainly preferable most of the time since dumping full SCMI messages to
the trace buffer involves a full copy of the payload.

For this reason I added a new distinct trace_scmi_msg_dump with this series
in order to be able to selectively enable at will message dumping only when
required.

Only successfully transmitted and received (valid) xfers are dumped.

Following the advice from Jim, I added some parsing/interpretation of the
header, so that the final result is something like:

root@deb-guest:~# echo 1 > /sys/kernel/debug/tracing/events/scmi/scmi_msg_dump/enable 
root@deb-guest:~# cat /sys/kernel/debug/tracing/trace_pipe 

 ++ cmd/reply
    sugov:0-257     [000] .....   401.954788: scmi_msg_dump: pt=13 t=CMND msg_id=07 seq=0082 s=0 pyld=0000000000000000
     <idle>-0       [000] d.h2.   401.955085: scmi_msg_dump: pt=13 t=RESP msg_id=07 seq=0082 s=0 pyld=


 ++ cmd/reply/delayed
   cat-263     [001] .....   471.533806: scmi_msg_dump: pt=15 t=CMND msg_id=06 seq=008A s=0 pyld=0100000001000000
<idle>-0       [000] d.h2.   471.554001: scmi_msg_dump: pt=15 t=RESP msg_id=06 seq=008A s=0 pyld=
<idle>-0       [000] d.h2.   471.574102: scmi_msg_dump: pt=15 t=DLYD msg_id=06 seq=008A s=0 pyld=01000000a05a320000000000efbeaddefecafeca


 ++ enable notif/notif
iio_generic_buf-282     [000] .....   535.327307: scmi_msg_dump: pt=15 t=CMND msg_id=0A seq=00AB s=0 pyld=0800000003000000
         <idle>-0       [000] d.h2.   535.327561: scmi_msg_dump: pt=15 t=RESP msg_id=0A seq=00AB s=0 pyld=00000000
         <idle>-0       [000] d.h2.   535.334421: scmi_msg_dump: pt=15 t=NOTI msg_id=01 seq=0000 s=0 pyld=000000000800000008daffffffffffff008268d4c075fd1610daffffffffffff008268d4c075fd1618daffffffffffff008268d4c075fd16
         <idle>-0       [000] d.h2.   535.434649: scmi_msg_dump: pt=15 t=NOTI msg_id=01 seq=0000 s=0 pyld=000000000800000009daffffffffffff008268d4c075fd1611daffffffffffff008268d4c075fd1619daffffffffffff008268d4c075fd16

Payload is dumped as it comes through byte-by-byte without any endianity
conversion to avoid further load on the system.

Thanks,
Cristian

---
V1 --> V2
- changed dumping format

Cristian Marussi (2):
  include: trace: Add SCMI full message tracing
  firmware: arm_scmi: Use new SCMI full message tracing

 drivers/firmware/arm_scmi/driver.c | 21 ++++++++++++++++++++
 include/trace/events/scmi.h        | 31 ++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

-- 
2.32.0

