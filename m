Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B65C4F1598
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 15:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350011AbiDDNO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 09:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349514AbiDDNOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 09:14:22 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C40B3A186
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 06:12:26 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r10so5295120eda.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 06:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QmcosJ0awvDxQa0wViF9xFspilUbHFNWDRIzA6YRAYc=;
        b=cHeWBkvDqpk6gM5OtQBV1AQ2CcgskHZNbkbu9z8QFjxmF7eatwS5PLikWHc6HPpmP1
         tv12HLMBBZ80ZLDuLTPf2fSMeQa4E9z1SYlSAP1BUuoNhc37cjpX+MF1n5/t2wLVZFqL
         d08B0tTV4SlH2quTJBbPIpJyuRNTZRiGTfIZUIVUSi2F4JADuWx51aw0qlShwH5CqVkx
         HxYCbeW5CXmoi6ikZ8lj+hBeaR998l0j4N6m4hsnp4CeJN5rvzIPWMcdWgeY63T6Sfii
         AjNK7qYwq35ZsDdPwQdCTRejxvJIWvkU1HQnVtyHVpyostVNC/jUu/PM9bmY1B+6X0Na
         S40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QmcosJ0awvDxQa0wViF9xFspilUbHFNWDRIzA6YRAYc=;
        b=eOTm+Z7V/3QuzqLmm6jPEDGA39+Ikb7QYly4cyNUvcfZD+E8tYFHD8/xJh8Fbq8ist
         3i/1Fc9aV3aVja302Qk+UhP+i4I2cG91CjTy264ExH8SNtMuoXntuYOs8fOvacJuTPwx
         aHL+w9affXXcUxCuLbJ26uaSRRC5PqqAVfhCe2Tgmv/2ucKJPkIASpTbqddS2vC7C4ae
         kR9PNdACU8i2vV2Mf6K2uhQtnzWYrdB/bOcI4Cod4MjBT601TpQYw66bywMjvKqlms2Y
         Dm1i3SOus5XGkLvxoAc5bUz/1OFdd1l9JQvk5v6mpJihMttvH00H1U93ARS3ZLPUnZan
         6Nbw==
X-Gm-Message-State: AOAM5310yrcRyb4N8B5bzwF9+SCH5geqy5MB/SBi5ucNTk7r+hMXlAy8
        pD2mCp9Relf6nisxTLbtVwyHxWRAWk79U0W224UM4/hGrg==
X-Google-Smtp-Source: ABdhPJzN1FMjrk/6In/zmo4L2tEiDyBdXxhGK6DXu35yVN7V5CTGZfY8ya4cR+Ra29rH8moZQ66KuIJ4MpqvVv6TUZM=
X-Received: by 2002:a05:6402:350d:b0:419:547f:134a with SMTP id
 b13-20020a056402350d00b00419547f134amr33564821edd.405.1649077944906; Mon, 04
 Apr 2022 06:12:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220404022317.2449865-1-yang.yang29@zte.com.cn>
In-Reply-To: <20220404022317.2449865-1-yang.yang29@zte.com.cn>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 4 Apr 2022 09:12:13 -0400
Message-ID: <CAHC9VhQYJuira79eEpGFSGz=63gu7RdT3i3sSzPh_tbmMKo5vA@mail.gmail.com>
Subject: Re: [PATCH v2] audit: do a quick exit when syscall number is less
 than 0
To:     cgel.zte@gmail.com
Cc:     eparis@redhat.com, linux-audit@redhat.com, rth@twiddle.net,
        sgrubb@redhat.com, linux-kernel@vger.kernel.org,
        ink@jurassic.park.msu.ru, mattst88@gmail.com,
        Yang Yang <yang.yang29@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 3, 2022 at 10:23 PM <cgel.zte@gmail.com> wrote:
>
> From: Yang Yang <yang.yang29@zte.com.cn>
>
> Userspace may use syscall with syscall number less than 0 by calling
> syscall(syscall_num,..). This kind of syscall could never be audited,
> because auditctl requires rule with syscall number >=0. Therefore we
> better do a quick handle no need to gohead with this situation.
>
> Note that auditctl may set rules auditing invalid syscall with syscall
> number bigger than NR_syscalls, to keep this mechanism working, we do
> no more check(context->major bigger than NR_syscalls or not).
>
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> ---
> v2:
> - cancel checking against NR_syscalls
> ---
>  kernel/auditsc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

As discussed previously, this is not something I want to merge
upstream at this time.

-- 
paul-moore.com
