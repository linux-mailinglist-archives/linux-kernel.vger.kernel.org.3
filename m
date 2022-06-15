Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B1E54BF8B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 04:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238468AbiFOCDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 22:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236508AbiFOCDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 22:03:11 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5090B31370
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 19:03:10 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v14so13421883wra.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 19:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ipK2xVBLHPOftN34BUGWDsuGecY3n8XAM7hkfiv9VF4=;
        b=Zen+bt9CQG1jdU1YiXYkeHp9jlh/y0vhgUUgRbxEZorTRPzLh8JTV5pMycsNGdDP0t
         G68vwkv78mv6nAbqqd/4LrH2Rj0/SQwOT85GtDJ0x8VDpQER+SL2Rk59c0guy3EPYyhN
         IVeSqTTw/+zH4ykdL7br+qCy0o28w0gxq0L7NS30DUgUw+r3svCpKu9bErunvw8vzQ7N
         esxy7hKjzLZ+a+bSkOB+oBx5HEV0Upg9iog+2CoxTxAmNeGWWdlvW80OigRUPXn1AFX8
         eFPOqzBZkoIckGZ9lTPDw2txUnxiuSdEp5poFo61UnLJmpZKZTFHKr5jdYFo5d9wJUk5
         AgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ipK2xVBLHPOftN34BUGWDsuGecY3n8XAM7hkfiv9VF4=;
        b=jL8n0oqbO4wfyA7PB05LqAYz61USJsJEQD3q6NgCTUOlWw6wOR2EUYwe55IrUS67qJ
         pO++89slgLX0rpW1L425sj+uucMJR1/rerRP7d1j6O25b0mHANtvTCty8Mx35UvwE8Rj
         zDQ8v5D4kff6LidU0Jp0PmRgge1Wgd0Em39K8fEMexbNFMrDhsChZctdEc+7pT8ErCn3
         E2SJVjROrXW8T5dVvbtuCfYFtGLNa3AgrRUkfp8D+3eC6QrqyLSeXYWDUNyiapizD03B
         ltnDhh+qSEsv054IMF2gM/S1L+lq4E581XIE3UXl/T0G+aFretOGgljeVFOmib8jXCTu
         ywdg==
X-Gm-Message-State: AJIora9k8o/Xb+bChS33LYhBuNyTeDOB3H3CC/4um8fibwHbVYFW8BpG
        50ceor0P1pOM2ivEg+MDOAfcKZqWulxTAqAGoRxV
X-Google-Smtp-Source: AGRyM1uENCeZZiPlJ60c8bFL+8XMUT4yEx1bjPhq9c8jfwIxvy/DROo9GfXYu0M9IaIA2YUcX+QZ9K7MdkLEOuwYH0Y=
X-Received: by 2002:a5d:6348:0:b0:213:3a8e:e75d with SMTP id
 b8-20020a5d6348000000b002133a8ee75dmr7142240wrw.55.1655258588850; Tue, 14 Jun
 2022 19:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220614132333.143042-1-xiujianfeng@huawei.com>
In-Reply-To: <20220614132333.143042-1-xiujianfeng@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 14 Jun 2022 22:02:58 -0400
Message-ID: <CAHC9VhQdfPBn4kbY0xRPaCvNBJJGdQQe_90A4Hhdsj6gVr6pAQ@mail.gmail.com>
Subject: Re: [PATCH -next] selinux: Fix memleak in security_read_policy
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        cgzones@googlemail.com, austin.kim@lge.com, omosnace@redhat.com,
        michalorzel.eng@gmail.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 9:25 AM Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
>
> In this function, it directly returns the result of __security_read_policy
> without freeing the allocated memory in *data, cause memory leak issue,
> so free the memory if __security_read_policy failed.
>
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  security/selinux/ss/services.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

This is another case where there is not actually a memory leak as the
only caller of security_read_policy() is sel_open_policy() which will
free the buffer it passes to security_read_policy() on error.

If you want you could add a comment to security_read_policy()
indicating that the caller is responsible for freeing the memory.

-- 
paul-moore.com
