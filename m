Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D4C4B80E7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 08:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiBPHDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 02:03:11 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiBPHDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:03:09 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DECA2B6D64
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 23:02:48 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id j12so1280457qtr.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 23:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=IV3FPtEnsUXk8oMp48bq68PERCfU0wMBWQO4LKNQXdQ=;
        b=QIV+jlqu6fvKp1QYlRNOIShzVZOFKv9OjsVpegSb9qgT61agwFKN322mX6v+9sangF
         w34t+f6KeN9DpwhHIf8QhPzuo9ToQw6NALxOmv3JHkV5VfLrIcivKKJxhblm5AWU9iYT
         hRCRB/9v3rFE3yLFIIp/xYBPuZII9s25CpaxpH32gaDhA2aMJBvOZjN1kAvxJzkN7qqZ
         N067oLE8K9u56fSV3gRRubAnlc84SmAhQTkCO7hYS2Xtz6+Cqw2Xr505Dlie9mheFg4H
         MzfWFahN0qM8KWDPf+egZunuYdmf3xL2rOylg8k+6A9fvvmog2SclAAh0cJFTDX/qbZk
         JcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=IV3FPtEnsUXk8oMp48bq68PERCfU0wMBWQO4LKNQXdQ=;
        b=JozcigVpja2wn2HZQ30yz1+RN8ZlVR2zNVwzJ2PIEjrwLdvAtt4M0O6HLYN0WvqRXw
         1NPg8+7YfRIONrb3d1DnSaVyC0H0bP/wgKNLLvFiFIsStezuSroC4tPJRSt2vcA1jSH3
         Z38WuJAh/dJXwQheoZrJY5siRKT3EYpkQpzlefxNtXXgb+/Wm8JkTyPHBcpFRXNTykdA
         nU68mZPGfW6+uIaNEgfo1OQYE0owNVY9ROuHuCy34r02c/+NPH1pZufa/sf53lCKeX++
         8i7kUKTjdWHlq+Ql9Fzbn6Bd/cDCqD9h8dsnYD5CFs2djW0/ITVHnk9DiwxXjOcmreLy
         qy7g==
X-Gm-Message-State: AOAM532Os8kVV3BWFkp8ck4v5IKYN2wdoKkMPDsEOqeCCejNnv8Cutfp
        qg7odhZezSF9haR1TCdUVv4KNDaoXsk=
X-Google-Smtp-Source: ABdhPJy5Y5fq7G10KLe7Xka551ZsrYaR34pM3sRqhmoK2ERIiKSseTy5n1RVa47e+qktgUrP5S93JA==
X-Received: by 2002:ac8:7f49:0:b0:2cd:a931:a423 with SMTP id g9-20020ac87f49000000b002cda931a423mr1012389qtk.650.1644994665431;
        Tue, 15 Feb 2022 22:57:45 -0800 (PST)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id e16sm21727706qty.47.2022.02.15.22.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 22:57:44 -0800 (PST)
Message-ID: <620ca068.1c69fb81.d3595.69fa@mx.google.com>
X-Google-Original-Message-ID: <20220216065742.GA1864737@cgel.zte@gmail.com>
Date:   Wed, 16 Feb 2022 06:57:42 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     hughd@google.com, mike.kravetz@oracle.com, kirill@shutemov.name,
        songliubraving@fb.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yang.yang29@zte.com.cn,
        wang.yong12@zte.com.cn, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] Fix shmem huge page failed to set
 F_SEAL_WRITE attribute problem
References: <20220215073743.1769979-1-cgel.zte@gmail.com>
 <20220215141236.de1a3eca3a8a52d04507c50f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215141236.de1a3eca3a8a52d04507c50f@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

O Tue, Feb 15, 2022 at 02:12:36PM -0800, Andrew Morton wrote:
> On Tue, 15 Feb 2022 07:37:43 +0000 cgel.zte@gmail.com wrote:
> 
> > From: wangyong <wang.yong12@zte.com.cn>
> > 
> > After enabling tmpfs filesystem to support transparent hugepage with the
> > following command:
> >  echo always > /sys/kernel/mm/transparent_hugepage/shmem_enabled
> > The docker program adds F_SEAL_WRITE through the following command will
> > prompt EBUSY.
> >  fcntl(5, F_ADD_SEALS, F_SEAL_WRITE)=-1.
> > 
> > It is found that in memfd_wait_for_pins function, the page_count of
> > hugepage is 512 and page_mapcount is 0, which does not meet the
> > conditions:
> >  page_count(page) - page_mapcount(page) != 1.
> > But the page is not busy at this time, therefore, the page_order of
> > hugepage should be taken into account in the calculation.
> 
> What are the real-world runtime effects of this?
>
The problem I encounter is that the "docker-runc run busybox" command
fails, and then the container cannot be started. The following alarm is
prompted:
[pid  1412] fcntl(5, F_ADD_SEALS,F_SEAL_SEAL|F_SEAL_SHRINK|F_SEAL_GROW|F_SEAL_WRITE) = -1 EBUSY (Device or resource busy)
[pid  1412] close(5)                    = 0
[pid  1412] write(2, "nsenter: could not ensure we are"..., 74) = 74
...
[pid  1491] write(3, "\33[31mERRO\33[0m[0005] container_li"..., 166) = 166
[pid  1491] write(2, "container_linux.go:299: starting"..., 144container_linux.go:299: starting container process caused
"process_linux.go:245: running exec setns process for init caused \"exit statu" ) = 144

I'm not sure how this will affect other situations.
> Do we think that this fix (or one similar to it) should be backported
> into -stable kernels?
> 
> If "yes" then Mike's 5d752600a8c373 ("mm: restructure memfd code") will
> get in the way because it moved lots of code around.
> 
Yes, 4.14 does not have this patch, but 4.19 does.
In addition, Kirill A. Shutemov's 800d8c63b2e989c2e349632d1648119bf5862f01 
(shmem: add huge pages support) is not included in 4.4, but it is available in 4.14.

> But then, that's four years old and perhaps that's far enough back in
> time.

Thanks.
