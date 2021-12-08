Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4958346CF52
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 09:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhLHIrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 03:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhLHIrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 03:47:31 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAF0C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 00:43:59 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id x15so5954759edv.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 00:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MHRdV/n7ZNhpIRjNRLtEErUQNiFQssJXqEFUzgk7Vxc=;
        b=qXhE/1Y+LCgOH7m0jy2P+VYemRpPHl74NzF59/uHj3WElZfVGD0GzBdr86e6GzLs8v
         rgPyIpPxARGLhF1XHUMCqwqHU92qA4tKXuWU5xrvab1rlKAfxSFe3PLbIqXI28VlbKFb
         adSMCWTECg1ho3UTKFyUE65/BcnLrxkT5y2VhtmWPU+++ev/IMopygNI45DvhisjXZZx
         ZHDMsNPsRfZBN2fmEqsL2lE2fWDZaTAKZOIT7QJd/1PMdYFslZGZxfkKwTSSgkHwizaw
         ChXkj/nXB/O6/ASnJDxJl40iPuCo+IFve5SBNhxbbvtTUUZpeTwP99I1OdUrZJkvsPVP
         WKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MHRdV/n7ZNhpIRjNRLtEErUQNiFQssJXqEFUzgk7Vxc=;
        b=vSZpANUgm0Mh0Mnad92abvx5rN2RUZHxJtMouSBdxcIPVPCT5QOUeWnnNs1dyAAKvV
         7t+SJCCzrC2BuLDAfkn9/e4nc2db6GJKuuNDC1TfDM/DEB22rTuRKO/nSHBM6RClRybg
         Yk/ULGIKrp/eWl2RXVzYHIo38TzkohPy2HoZpc9HfsPcvrKH6era3Bn6RKdGyieNg/Nv
         ARatbUHNoAMm3rDdmMgI3aw3l88+/AQcZd2EDdc5LobriLbuGO0cqBJ/FXvq/7dKqIgO
         xyubVmNeZwewW6tke4HFnnh9h5HmPqJT2ex0dUsMEpPEbUXIqwW1ygsmTr3lbnKbZDu4
         2ygQ==
X-Gm-Message-State: AOAM5300HM/u9Zy9DZMIBCBJ27tf0ay0fqXXzsAwmulWT1OcOXjOpIUL
        nqcKtsdCBQpvpRg29hKiAVJzYg==
X-Google-Smtp-Source: ABdhPJxxUorbWcPYmJ7REYy3pVVDwvJxoaNH3KHAFRqt9w8nDDvoDGgB+bnyyKCkPtGomBbC5wLYug==
X-Received: by 2002:a17:907:7805:: with SMTP id la5mr5842317ejc.188.1638953038538;
        Wed, 08 Dec 2021 00:43:58 -0800 (PST)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id z8sm1585993edb.5.2021.12.08.00.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 00:43:58 -0800 (PST)
Date:   Wed, 8 Dec 2021 09:43:56 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Shay Drory <shayd@nvidia.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, jiri@nvidia.com,
        saeedm@nvidia.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [PATCH net-next v2 1/6] devlink: Add new "io_eq_size" generic
 device param
Message-ID: <YbBwTNwmuZNwjVZU@nanopsycho>
References: <20211208070006.13100-1-shayd@nvidia.com>
 <20211208070006.13100-2-shayd@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208070006.13100-2-shayd@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Dec 08, 2021 at 08:00:01AM CET, shayd@nvidia.com wrote:
>Add new device generic parameter to determine the size of the
>I/O completion EQs.
>
>For example, to reduce I/O EQ size to 64, execute:
>$ devlink dev param set pci/0000:06:00.0 \
>              name io_eq_size value 64 cmode driverinit
>$ devlink dev reload pci/0000:06:00.0
>
>Signed-off-by: Shay Drory <shayd@nvidia.com>
>Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
>---
> Documentation/networking/devlink/devlink-params.rst | 3 +++
> include/net/devlink.h                               | 4 ++++
> net/core/devlink.c                                  | 5 +++++
> 3 files changed, 12 insertions(+)
>
>diff --git a/Documentation/networking/devlink/devlink-params.rst b/Documentation/networking/devlink/devlink-params.rst
>index b7dfe693a332..cd9342305a13 100644
>--- a/Documentation/networking/devlink/devlink-params.rst
>+++ b/Documentation/networking/devlink/devlink-params.rst
>@@ -129,3 +129,6 @@ own name.
>        will NACK any attempt of other host to reset the device. This parameter
>        is useful for setups where a device is shared by different hosts, such
>        as multi-host setup.
>+   * - ``io_eq_size``
>+     - u16

Hmm, I wonder if this wouldn't be better to have it 32bits which might
be future safe.

Otherwise, this looks fine.


>+     - Control the size of I/O completion EQs.
>diff --git a/include/net/devlink.h b/include/net/devlink.h
>index 3276a29f2b81..61efa45b8786 100644
>--- a/include/net/devlink.h
>+++ b/include/net/devlink.h
>@@ -459,6 +459,7 @@ enum devlink_param_generic_id {
> 	DEVLINK_PARAM_GENERIC_ID_ENABLE_RDMA,
> 	DEVLINK_PARAM_GENERIC_ID_ENABLE_VNET,
> 	DEVLINK_PARAM_GENERIC_ID_ENABLE_IWARP,
>+	DEVLINK_PARAM_GENERIC_ID_IO_EQ_SIZE,
> 
> 	/* add new param generic ids above here*/
> 	__DEVLINK_PARAM_GENERIC_ID_MAX,
>@@ -511,6 +512,9 @@ enum devlink_param_generic_id {
> #define DEVLINK_PARAM_GENERIC_ENABLE_IWARP_NAME "enable_iwarp"
> #define DEVLINK_PARAM_GENERIC_ENABLE_IWARP_TYPE DEVLINK_PARAM_TYPE_BOOL
> 
>+#define DEVLINK_PARAM_GENERIC_IO_EQ_SIZE_NAME "io_eq_size"
>+#define DEVLINK_PARAM_GENERIC_IO_EQ_SIZE_TYPE DEVLINK_PARAM_TYPE_U16
>+
> #define DEVLINK_PARAM_GENERIC(_id, _cmodes, _get, _set, _validate)	\
> {									\
> 	.id = DEVLINK_PARAM_GENERIC_ID_##_id,				\
>diff --git a/net/core/devlink.c b/net/core/devlink.c
>index db3b52110cf2..0d4e63d11585 100644
>--- a/net/core/devlink.c
>+++ b/net/core/devlink.c
>@@ -4466,6 +4466,11 @@ static const struct devlink_param devlink_param_generic[] = {
> 		.name = DEVLINK_PARAM_GENERIC_ENABLE_IWARP_NAME,
> 		.type = DEVLINK_PARAM_GENERIC_ENABLE_IWARP_TYPE,
> 	},
>+	{
>+		.id = DEVLINK_PARAM_GENERIC_ID_IO_EQ_SIZE,
>+		.name = DEVLINK_PARAM_GENERIC_IO_EQ_SIZE_NAME,
>+		.type = DEVLINK_PARAM_GENERIC_IO_EQ_SIZE_TYPE,
>+	},
> };
> 
> static int devlink_param_generic_verify(const struct devlink_param *param)
>-- 
>2.21.3
>
