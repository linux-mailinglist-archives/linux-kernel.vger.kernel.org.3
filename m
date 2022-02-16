Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E29F4B93CB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 23:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236962AbiBPWX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 17:23:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiBPWX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 17:23:57 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CFA23D3E8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 14:23:44 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id x193so4070809oix.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 14:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=etImQ23DAZIyzcxTwTxDAxV3XR2BJnFRKu2LqXMWoqU=;
        b=KwZO2o68tDAEuLAP2TegGGwElBl6cuxgX+6HbgI1CxuTGNGKYdYuLBtywRc2rRHdQ0
         3fATQKA4POTJc42ZDeotqFZnxo3vQgdt9vNUYVapUL9o4VXx3mxLh0U/NB4Vt+umrw+k
         kYSYaAav7BK27ps7coN4n0fWmEiIsEE74hh4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=etImQ23DAZIyzcxTwTxDAxV3XR2BJnFRKu2LqXMWoqU=;
        b=eIhzDV1dlkIFcyL9Q9H9QsNNJz+t9qMdV1Cz+f1Jt5NvlOnCFdm1aLlDJyieG0Z1UG
         olgiUA8Us3Cd3nUHzje44HhkK/lJEkhj8W1uQl6qcNjbX48qIkXmnETDhviYNs0Yt7ZK
         J+W0awo34O0wXZOvzHmxpI9nux0q7DgO8MHgsioRByQf8hQ3Ja+msJPwfdYNmAZHFSPE
         BGM8QmJXMD7cB/Qbbq7cAxApeHr3c0syrt74lj8sOQsHMxMCjBCGhmh+8u2DgyxAEZc1
         MjgzFKvmf5xNiFlk8zkMojDy9PZQIME2swBsejVGAbmT5LDcvZWxyM305s8myfmOXpty
         5u6w==
X-Gm-Message-State: AOAM53272tItsNjpn+In8VxN8FHNatd/KmuKRiz0ZMRw3XqCHzohOc/z
        +BrAh8z1+XqIQ/BU/UhngE6KJEsgWD8OE0ETDEDGQw==
X-Google-Smtp-Source: ABdhPJwn/ECp05OMNkph5imVMHaRBfxeZSEX/tNG0rz21h4n35xqEfdR4dfmwglp6oMZXxQKuBnPaZ1qtqmNSlHYcnE=
X-Received: by 2002:a05:6808:b2f:b0:2cf:9af3:1687 with SMTP id
 t15-20020a0568080b2f00b002cf9af31687mr12629oij.112.1645050223557; Wed, 16 Feb
 2022 14:23:43 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 16 Feb 2022 14:23:43 -0800
MIME-Version: 1.0
In-Reply-To: <20220216195901.1326924-2-swboyd@chromium.org>
References: <20220216195901.1326924-1-swboyd@chromium.org> <20220216195901.1326924-2-swboyd@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 16 Feb 2022 14:23:42 -0800
Message-ID: <CAE-0n51wWOp9Ku8auZ5x_oSwmgAvNsnKk6J0=kq1rmDXwrT2Zw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] Input: Extract ChromeOS vivaldi physmap show function
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        "Sean O'Brien" <seobrien@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2022-02-16 11:58:58)
> diff --git a/include/linux/input/vivaldi-fmap.h b/include/linux/input/vivaldi-fmap.h
> new file mode 100644
> index 000000000000..57563d9da022
> --- /dev/null
> +++ b/include/linux/input/vivaldi-fmap.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _VIVALDI_KEYMAP_H
> +#define _VIVALDI_KEYMAP_H

Doug pointed out this missed the update. This patch can be squashed in.

---8<---
diff --git a/include/linux/input/vivaldi-fmap.h
b/include/linux/input/vivaldi-fmap.h
index c736200b4511..a0784a6e7a1c 100644
--- a/include/linux/input/vivaldi-fmap.h
+++ b/include/linux/input/vivaldi-fmap.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _VIVALDI_KEYMAP_H
-#define _VIVALDI_KEYMAP_H
+#ifndef _VIVALDI_FMAP_H
+#define _VIVALDI_FMAP_H

 #include <linux/types.h>

@@ -34,4 +34,4 @@ void vivaldi_hid_feature_mapping(struct vivaldi_data *data,
 				 struct hid_field *field,
 				 struct hid_usage *usage);

-#endif /* _VIVALDI_KEYMAP_H */
+#endif /* _VIVALDI_FMAP_H */
