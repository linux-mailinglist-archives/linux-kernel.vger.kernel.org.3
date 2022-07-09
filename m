Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4176656C58B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 02:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiGIAzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 20:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiGIAzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 20:55:31 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E65691EB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 17:55:29 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id q5-20020a17090a304500b001efcc885cc4so164071pjl.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 17:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5tfoXTTrku/dQJy1oFSssPrlHXbJM14k7EhQ5B1YVWk=;
        b=RFZ/9uNlT+kbKB+KcbIS08mBkVVSXOnVZkTk2JLCBDJCF8QLX+EnxUJ7RtKaN1um+n
         TedWU8xcqGINBOAJd4IaUMQ4ft7TgD+ZRRX7TKyxcvWImnmXvNrpoYMcT+0uFlkmMvFm
         v4X2hB2ZP75HgYmHGThxq1r0MMQgTtACrxDW1arL8xmOVJYvAyzz9Hlm5vil7sq59ih9
         It7zX4nW/Exd9JhuFX8+NQxuFrtADvy255NN2Opg/T/7H9Tdf0Jj1W530sU55R9JhIfZ
         vGsDU7lVfwM8byerNxhh5njyVOCwR8TKQmpkgrsB8GiQzDKp18KAmVHCCopqnNTRn0A7
         8zzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5tfoXTTrku/dQJy1oFSssPrlHXbJM14k7EhQ5B1YVWk=;
        b=IEgbNC0xb/B8RVBF2LXS4Z7Nl6ONBRIHOOAAikYeiXkgGXGlJgvDWfknmOlEVZ0x5L
         OKqy49Rh+ZpOWohp+cCU0Ra3GrHcLCJMziv8AubwVyz4vXV7i0OtT4Pt4xBWJor+W5vB
         6SmbHvd4cM0itivpQ2c+d/bI6E+U8IxrFhtgQNjjPTafsceYQlSrALoy4PzKbjg1dLXA
         8gG0Hnn76wjDgA9BhP12RwlZKdLLTc4MHaFBS+k0UfpTQyW7yGD/CYxuIyJvQcAkm67O
         zQS16h1OvTmZCMazmP7M7uagfCmMGcfdvZEEzRAnliZzaBWj1UwNtnSR9WXGNVNDeiCx
         7xnQ==
X-Gm-Message-State: AJIora8znvnr5bBrccGvpDRMrY02VLVHOSYP/5vUjXeqxTQILWrvQtV5
        jSzti7pTwW8l6qn2RNkTFmA=
X-Google-Smtp-Source: AGRyM1uEGMgEeHvZ7/1r1lHZfwXyQnGYSx1n4aEw+xWLRHCwPwOJvo7eLXnlY8Hkr62r/X/jaeMZOg==
X-Received: by 2002:a17:902:e542:b0:16b:fcbe:7b90 with SMTP id n2-20020a170902e54200b0016bfcbe7b90mr6384914plf.90.1657328128595;
        Fri, 08 Jul 2022 17:55:28 -0700 (PDT)
Received: from ubuntu.lan (pcd568068.netvigator.com. [218.102.100.68])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902c2c500b0016beea47800sm152394pla.41.2022.07.08.17.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 17:55:28 -0700 (PDT)
From:   Hawkins Jiawei <yin31149@gmail.com>
To:     chenxiaosong2@huawei.com
Cc:     akpm@linux-foundation.org, anton@tuxera.com,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        liuyongqiang13@huawei.com, yi.zhang@huawei.com,
        zhangxiaoxu5@huawei.com, 18801353760@163.com,
        skhan@linuxfoundation.org, paskripkin@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] ntfs: fix use-after-free in ntfs_ucsncmp()
Date:   Sat,  9 Jul 2022 08:54:51 +0800
Message-Id: <20220709005450.2220-1-yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707105329.4020708-1-chenxiaosong2@huawei.com>
References: <20220707105329.4020708-1-chenxiaosong2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Fix this by adding sanity check on end address of attibute name string.

> diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> index 4de597a83b88..9ab8766872d2 100644
> --- a/fs/ntfs/attrib.c
> +++ b/fs/ntfs/attrib.c
> @@ -592,8 +592,12 @@ static int ntfs_attr_find(const ATTR_TYPE type, const ntfschar *name,
>  		a = (ATTR_RECORD*)((u8*)ctx->attr +
>  				le32_to_cpu(ctx->attr->length));
>  	for (;;	a = (ATTR_RECORD*)((u8*)a + le32_to_cpu(a->length))) {
> -		if ((u8*)a < (u8*)ctx->mrec || (u8*)a > (u8*)ctx->mrec +
> -				le32_to_cpu(ctx->mrec->bytes_allocated))
> +		u8 *mrec_end = (u8 *)ctx->mrec +
> +		               le32_to_cpu(ctx->mrec->bytes_allocated);
> +		u8 *name_end = (u8 *)a + le16_to_cpu(a->name_offset) +
> +		               a->name_length;

In my opinion, name_length field just means the number of characters,
yet each character is a ntfschar type. So name should be
name_length * sizeof(ntfschar) bytes. The example is at
https://elixir.bootlin.com/linux/v5.19-rc5/source/fs/ntfs/attrib.c#L1667

> +		if ((u8*)a < (u8*)ctx->mrec || (u8*)a > mrec_end ||
> +		    name_end > mrec_end)
>  			break;
>  		ctx->attr = a;
>  		if (unlikely(le32_to_cpu(a->type) > le32_to_cpu(type) ||
> -- 

