Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B904AD96D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242239AbiBHNSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345748AbiBHMjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 07:39:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7942CC03FEC0;
        Tue,  8 Feb 2022 04:39:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3EF67B81886;
        Tue,  8 Feb 2022 12:39:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A81FC004E1;
        Tue,  8 Feb 2022 12:39:33 +0000 (UTC)
Message-ID: <37c856c6-caa3-b908-9cda-25a50a50ef03@xs4all.nl>
Date:   Tue, 8 Feb 2022 13:39:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] Add check for READ ONLY flag
Content-Language: en-US
To:     Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        vgarodia@codeaurora.org
References: <1643957268-6365-1-git-send-email-quic_dikshita@quicinc.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <1643957268-6365-1-git-send-email-quic_dikshita@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/4/22 07:47, Dikshita Agarwal wrote:
> Add a check for V4L2_CTRL_FLAG_READ_ONLY to avoid request
> testing for such controls.

Missing Signed-off-by!

Regards,

	Hans

> ---
>  utils/v4l2-compliance/v4l2-test-buffers.cpp | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/utils/v4l2-compliance/v4l2-test-buffers.cpp b/utils/v4l2-compliance/v4l2-test-buffers.cpp
> index fa8c37c..b8de7af 100644
> --- a/utils/v4l2-compliance/v4l2-test-buffers.cpp
> +++ b/utils/v4l2-compliance/v4l2-test-buffers.cpp
> @@ -2032,7 +2032,8 @@ int testRequests(struct node *node, bool test_streaming)
>  		if (qctrl.type != V4L2_CTRL_TYPE_INTEGER &&
>  		    qctrl.type != V4L2_CTRL_TYPE_BOOLEAN)
>  			continue;
> -		if (qctrl.flags & V4L2_CTRL_FLAG_WRITE_ONLY)
> +		if (qctrl.flags & V4L2_CTRL_FLAG_WRITE_ONLY ||
> +		    qctrl.flags & V4L2_CTRL_FLAG_READ_ONLY)
>  			continue;
>  		if (is_vivid && V4L2_CTRL_ID2WHICH(qctrl.id) == V4L2_CTRL_CLASS_VIVID)
>  			continue;
