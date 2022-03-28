Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4C34E9D1D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 19:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244462AbiC1RO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 13:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbiC1RO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 13:14:26 -0400
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 41C4C633A3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 10:12:45 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1648487565; h=Message-ID: Subject: Subject: Cc: To: To: From:
 From: Date: Content-Transfer-Encoding: Content-Type: MIME-Version:
 Sender: Sender; bh=G5iJZr0M4mlw3qJ3OMr06OZ2pcO/8KQCx5X0APhrE1o=; b=WWyPmA4/JS14iipgHfrSOGQZGqjVyvj2/72ZXD3gncpZdSTAw6citgLILjTdkGCQN3VmDw7o
 6CViLJnSxT7EY7uiN8f8BEhpqpKmEsatmFO9pp6ux03KRkW1y2od45OsPhVej487dtiW0v0t
 BQrgNpjTPGPT2YMsQ1Z5KE8YBXk=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 6241ec8b486bf936da626882 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 28 Mar 2022 17:12:43
 GMT
Sender: vgarodia=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 05DDFC4360C; Mon, 28 Mar 2022 17:12:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: vgarodia)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8B3CCC4338F;
        Mon, 28 Mar 2022 17:12:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 28 Mar 2022 22:42:42 +0530
From:   vgarodia@codeaurora.org
To:     mchehab@kernel.org, hverkuil@xs4all.nl,
        stanimir.varbanov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vgarodia@quicinc.com
Subject: Proposal for a new video driver for Qualcomm upcoming SOCs
Message-ID: <90e7d1402f1f4ad3e43b7d1f8746aef0@codeaurora.org>
X-Sender: vgarodia@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

There is an existing video driver for Qualcomm SOCs [1]. There is a need 
for a separate driver for the new generations of video hardware in 
Qualcomm SOCs. It is needed, primarily for below reasons:-

1. HFI 2.0 interface (driver<->firmware interface) is a new non-backward 
compatible interface.
    a. HFI 2.0 is designed to suit future video hardware generations.
    b. Older interface (HFI 1.0) is supported till MSM8350 (SD 835). Any 
new video hardware would be supported *only* with the
       new HFI 2.0.

2. Video firmwares, which are based on HFI 1.0, were designed to follow 
khronos openmax IL 1.1.2 specification. Video firmware
    interface HFI 2.0 is designed based on v4l2 stateful codec 
specification.

This request is to share your suggestions or any queries to discuss on 
this proposal.
Incase any aspect to consider, before we start implementing the new 
driver.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/media/platform/qcom/venus

Regards,
Vikash

