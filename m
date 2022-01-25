Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8606349B34C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 12:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbiAYLqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 06:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356015AbiAYLlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 06:41:45 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8C3C06173B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 03:41:41 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id e17so3187242ljk.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 03:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RJcbe5w2XSHxzMRgZ2Y2pQFdn57O19rCLWQF0CALTH0=;
        b=kGRdpXqcvVI0JCXEBkcXAlaCnbgjqFw+y8JqKUUVByiZmzUD++/K6HXdokfYHT1e/s
         sxFaso5HE7DDGYcZVeGpk8Msnbaks/2Hjj29YYAaKOvfBHvyu9JdDdLsYD3EMoWOhT86
         bLX6DSF5pwDpP8/Ng2zMIQV/Vb/s/ltR+vKyYOtgvrsZ6+gU+V4SdJ4slvOgWET6E1+4
         DrD81m/LvFIUeiDn7bli+yM8Xff0h728ycJDGY6NdzW0+koC7t9lXNLHLwulYhjYI/lj
         zWnCnFyvYelEtdcajUL7Io5igV21i5JXiULGMX+wOkcwQcHeXAPJL3AP9en639+5B0fu
         NXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RJcbe5w2XSHxzMRgZ2Y2pQFdn57O19rCLWQF0CALTH0=;
        b=WhMQUtHVCAbULKjbpZQ8VvBdDEctb5vaWG/JbCkyZHamCoeWvO2eDuCrfCjvrf3+cG
         PlY2nRYfR4GWkQzagL4SdCPBlm1UMtxO4n+QbZPnIBfafi4o/FV+NXzIOGKiQij3b+QZ
         fTLpDWkIOI5ZZClz8B4IUh0cvekNVH2Yi4JjTGZirTYcEvw6QUd00FKKBg76z/EaEog/
         I98Gq7dGOZp7p/Ayyu+nnIiJ2rwCO0zlUFmNAdNAFLIk5qeE8NG0DGzSIZjRRTwSQ9aL
         J4cefi5teocb6x/BdFH9/0koipJkjlThN70uI4JKhYg/oMlLUUBarFJ+fNC+BK90dunQ
         Qi7A==
X-Gm-Message-State: AOAM532sx/cCgrHkPcjMJoplxnu8RkpdqOWqU2Q6vMsc9teE5rkYKIsN
        HxuIh/f+XqLa27OM7WPu/eBoKg==
X-Google-Smtp-Source: ABdhPJwgke+5vjX1u3fzSchnQ1ruulUVi80pUf5YCUch45nk/1nrAtCaqXa+Dvm5HWQKYysafwWsUQ==
X-Received: by 2002:a2e:3212:: with SMTP id y18mr3250783ljy.270.1643110899999;
        Tue, 25 Jan 2022 03:41:39 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id p19sm1463920lfh.18.2022.01.25.03.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 03:41:39 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 42B23103C0E; Tue, 25 Jan 2022 14:42:12 +0300 (+03)
Date:   Tue, 25 Jan 2022 14:42:12 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        longpeng2@huawei.com, arnd@arndb.de, dave.hansen@linux.intel.com,
        david@redhat.com, rppt@kernel.org, surenb@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/6] Add support for shared PTEs across processes
Message-ID: <20220125114212.ks2qtncaahi6foan@box.shutemov.name>
References: <cover.1642526745.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1642526745.git.khalid.aziz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 02:19:12PM -0700, Khalid Aziz wrote:
> Example Code
> ============
> 
> Snippet of the code that a donor process would run looks like below:
> 
> -----------------
>         addr = mmap((void *)TB(2), GB(512), PROT_READ | PROT_WRITE,
>                         MAP_SHARED | MAP_ANONYMOUS, 0, 0);
>         if (addr == MAP_FAILED)
>                 perror("ERROR: mmap failed");
> 
>         err = syscall(MSHARE_SYSCALL, "testregion", (void *)TB(2),
> 			GB(512), O_CREAT|O_RDWR|O_EXCL, 600);
>         if (err < 0) {
>                 perror("mshare() syscall failed");
>                 exit(1);
>         }
> 
>         strncpy(addr, "Some random shared text",
> 			sizeof("Some random shared text"));
> -----------------
> 
> Snippet of code that a consumer process would execute looks like:
> 
> -----------------
>         fd = open("testregion", O_RDONLY);
>         if (fd < 0) {
>                 perror("open failed");
>                 exit(1);
>         }
> 
>         if ((count = read(fd, &mshare_info, sizeof(mshare_info)) > 0))
>                 printf("INFO: %ld bytes shared at addr %lx \n",
> 				mshare_info[1], mshare_info[0]);
>         else
>                 perror("read failed");
> 
>         close(fd);
> 
>         addr = (char *)mshare_info[0];
>         err = syscall(MSHARE_SYSCALL, "testregion", (void *)mshare_info[0],
> 			mshare_info[1], O_RDWR, 600);
>         if (err < 0) {
>                 perror("mshare() syscall failed");
>                 exit(1);
>         }
> 
>         printf("Guest mmap at %px:\n", addr);
>         printf("%s\n", addr);
> 	printf("\nDone\n");
> 
>         err = syscall(MSHARE_UNLINK_SYSCALL, "testregion");
>         if (err < 0) {
>                 perror("mshare_unlink() failed");
>                 exit(1);
>         }
> -----------------

I wounder if we can get away with zero-API here: we can transparently
create/use shared page tables for any inode on mmap(MAP_SHARED) as long as
size and alignment is sutiable. Page tables will be linked to the inode
and will be freed when the last of such mapping will go away. I don't see
a need in new syscalls of flags to existing one.

-- 
 Kirill A. Shutemov
