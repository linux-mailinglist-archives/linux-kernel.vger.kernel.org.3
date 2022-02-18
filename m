Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A864BBAFA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 15:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235789AbiBROxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 09:53:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbiBROxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 09:53:30 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B37E48E54
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 06:53:13 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id c7so6000924qka.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 06:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=XCJgFl0zb6Np3SwMPpLvvP3l3nq1MdfLV+ikmQDUG3s=;
        b=AUPu13zo54l+idCIL+fH26rteHJK42TpmEDpDH/cjEYqJBmuqqTINgGSIP4WKKUs9B
         HomsZELFx2heoftLLvSzvUeXyxO5PmLsXZzFzfrS9k/QACvzHyzB5NcbphcDuFmb33ZG
         pg3zOvN9r/Jw5/V2Jtv7pZd/slHYzRvl8L5XTARxXKrOBHbrUYRlkhmmvmrTcOdFHm1A
         29QFqcKACAcGricMQ5Ey3GZKQbC2yfbaFvPRf6l4+b2YsPKSXGMUeXgIuNzQE3rDxK0A
         LNFBl/Ipx4zoGpucjh6jlD8cLZSxSwRgkXS8z8FsfC2UazNrpTunlXOdHMpnKZAN2DTg
         S2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=XCJgFl0zb6Np3SwMPpLvvP3l3nq1MdfLV+ikmQDUG3s=;
        b=2rfBi+cRpWGiFD1LJKT2InVe7pC8ZxJeLjZ+TbH5yF/3Jkk6/OuP+KkG1vwKow6UhX
         bWMdU1SVvdm2o+KilZXCebAM531T3uVpj92Zf4fFHoLI3Cpqm8g5ep/o4Mh2e+JpiWoa
         Tt21NepQCf7/gD03ojo65UGDEZ+6c4KiRtLbw3zmrNBpE8FUG8Oln6PENTIJGKFE2zMK
         KvKUIpB1enEgutAyMey8IyAuV6Zm/3JmmWWV3aj75fkSKJU9Luubx4kB5yLMEJ3DVuU3
         WsSiLQra6Z6d+fM49NSiyAh2z9jjqNi5x/+QcKbj5po+oTI37toJZt4fT1SqOQwiMUux
         oF9Q==
X-Gm-Message-State: AOAM532W+WXesIepNvsE3up7WE7ssd9yfeFSarRW9qcE4vH4btPafpLe
        R5KGgHouWKkOOaFSjpmtKDCCfg==
X-Google-Smtp-Source: ABdhPJwXH1h/po2pdL5t6lLulOVmk5rA2cO/TnGOOCjAdQ1pevbQSrVjLH/1u3+wQIHPgXNBctDZdg==
X-Received: by 2002:a37:bdc6:0:b0:47d:4c1f:817b with SMTP id n189-20020a37bdc6000000b0047d4c1f817bmr4699996qkf.154.1645195992776;
        Fri, 18 Feb 2022 06:53:12 -0800 (PST)
Received: from nicolas-tpx395.localdomain (173-246-12-168.qc.cable.ebox.net. [173.246.12.168])
        by smtp.gmail.com with ESMTPSA id bl34sm19728766qkb.15.2022.02.18.06.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 06:53:12 -0800 (PST)
Message-ID: <d2a039f25b5e359c4df1eb55d9f4ebcf66234d93.camel@ndufresne.ca>
Subject: Re: [PATCH v3 1/4] media: v4l2-ctrls: Add new
 V4L2_H264_DECODE_PARAM_FLAG_P/BFRAME flags
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 18 Feb 2022 09:53:11 -0500
In-Reply-To: <20220207141937.13089-2-digetx@gmail.com>
References: <20220207141937.13089-1-digetx@gmail.com>
         <20220207141937.13089-2-digetx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 07 février 2022 à 17:19 +0300, Dmitry Osipenko a écrit :
> Add new V4L2_H264_DECODE_PARAM_FLAG_P/BFRAME flags that are needed by
> NVIDIA Tegra video decoder. Userspace will have to set these flags in
> accordance to the type of a decoded frame.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Reviewed-by: Nicolas Dufresne <nicolas@collabora.com>

> ---
>  .../userspace-api/media/v4l/ext-ctrls-codec-stateless.rst   | 6 ++++++
>  include/uapi/linux/v4l2-controls.h                          | 2 ++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
> index cc080c4257d0..f87584ad90ba 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
> @@ -616,6 +616,12 @@ Stateless Codec Control ID
>      * - ``V4L2_H264_DECODE_PARAM_FLAG_BOTTOM_FIELD``
>        - 0x00000004
>        -
> +    * - ``V4L2_H264_DECODE_PARAM_FLAG_PFRAME``
> +      - 0x00000008
> +      -
> +    * - ``V4L2_H264_DECODE_PARAM_FLAG_BFRAME``
> +      - 0x00000010
> +      -
>  
>  .. raw:: latex
>  
> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
> index c8e0f84d204d..e3d48d571062 100644
> --- a/include/uapi/linux/v4l2-controls.h
> +++ b/include/uapi/linux/v4l2-controls.h
> @@ -1563,6 +1563,8 @@ struct v4l2_h264_dpb_entry {
>  #define V4L2_H264_DECODE_PARAM_FLAG_IDR_PIC		0x01
>  #define V4L2_H264_DECODE_PARAM_FLAG_FIELD_PIC		0x02
>  #define V4L2_H264_DECODE_PARAM_FLAG_BOTTOM_FIELD	0x04
> +#define V4L2_H264_DECODE_PARAM_FLAG_PFRAME		0x08
> +#define V4L2_H264_DECODE_PARAM_FLAG_BFRAME		0x10
>  
>  #define V4L2_CID_STATELESS_H264_DECODE_PARAMS	(V4L2_CID_CODEC_STATELESS_BASE + 7)
>  /**

