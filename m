Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1705A0B6C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbiHYI0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235780AbiHYI0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:26:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33341616E;
        Thu, 25 Aug 2022 01:25:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3FB4B825C6;
        Thu, 25 Aug 2022 08:25:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C656C433C1;
        Thu, 25 Aug 2022 08:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661415936;
        bh=qIOfflNjTg46rEZK8mbBXoX4G0/ieSgWMgNoJpIcvps=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=d2nDFQHVQxEtFpai1Y2914plsJk7dEKTEI7N7U/yApGRHjMsVF3uqN1Q/dLr5QDrp
         OYDKeQIJCbmnLOgy56iioWbYv1F3g8ax3L2Ux4LwzNqoAZT162uPuTB5HuHO5Sn8+y
         FMbmQ5328nwVb+J+z13XX8irIb8FJZ6dA93Lau80o2PsWftvWlHEwsyluvgjC+8cKM
         qIwGKh467FVAQOH4cUfuoZwOWnoeVMu7u3NnyRkRYvI3jSR1dXZjLs13NQqhicQj6I
         cUFDnBCpe+EV1qGBD0LaH5ugFLV5Tf2LSet4k55YhOQttngdM7mfNDLs2V4ujhAGhJ
         ZvPCzbC4ao8Fg==
Date:   Thu, 25 Aug 2022 10:25:32 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] HID: uclogic: Fix warning in
 uclogic_rdesc_template_apply
In-Reply-To: <20220815142706.18369-1-jose.exposito89@gmail.com>
Message-ID: <nycvar.YFH.7.76.2208251025250.19850@cbobk.fhfr.pm>
References: <20220815142706.18369-1-jose.exposito89@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Aug 2022, José Expósito wrote:

> Building with Sparse enabled prints this warning:
> 
>     warning: incorrect type in assignment (different base types)
>         expected signed int x
>         got restricted __le32 [usertype]
> 
> Cast the return value of cpu_to_le32() to fix the warning.
> 
> Fixes: 08177f4 ("HID: uclogic: merge hid-huion driver in hid-uclogic")
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> 
> ---
> 
> Kindly resending this patch so it doesn't get lost after the merge
> window.
> ---
>  drivers/hid/hid-uclogic-rdesc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-uclogic-rdesc.c b/drivers/hid/hid-uclogic-rdesc.c
> index 3d68e8b0784d..81ca22398ed5 100644
> --- a/drivers/hid/hid-uclogic-rdesc.c
> +++ b/drivers/hid/hid-uclogic-rdesc.c
> @@ -1113,7 +1113,7 @@ __u8 *uclogic_rdesc_template_apply(const __u8 *template_ptr,
>  		    memcmp(p, pen_head, sizeof(pen_head)) == 0 &&
>  		    p[sizeof(pen_head)] < param_num) {
>  			v = param_list[p[sizeof(pen_head)]];
> -			put_unaligned(cpu_to_le32(v), (s32 *)p);
> +			put_unaligned((__force u32)cpu_to_le32(v), (s32 *)p);
>  			p += sizeof(pen_head) + 1;
>  		} else if (memcmp(p, btn_head, sizeof(btn_head)) == 0 &&
>  			   p[sizeof(btn_head)] < param_num) {

Applied, thank you José.

-- 
Jiri Kosina
SUSE Labs

