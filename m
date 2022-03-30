Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DC94EC6A3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346929AbiC3Ogu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346512AbiC3Ogr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:36:47 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0667C41F93
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 07:35:02 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id kk12so16926443qvb.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 07:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8YEpYyj+slhz80KqGdO/dNLOYREGdFcjwe/TeO35Nn0=;
        b=hpNWqSzx8+OpQBKf3RHE2+m1O7JjkvzX+EWb/RiGRE+hEvh4mIlq0KfcrdX2Gw51+d
         uMStHTaBWipJXrOBSFCn6/H3IUKXYDYcpJo1tCKDWwMBKxgfYqqV+NKfRoyBzizSapqv
         cSqFIds+6Dt10gSEDXb9yrDz70oaxFDzqhIODOvObNv25g1FKZ2jOVNyrhy/xIZ28Yvu
         iR9qWmVYZBdGqVY7jjPA8/1emWMHz2JTcaU0Sljide6CQq2k0lSVGsRMjzdWjsAZ/EEi
         cD9yhyWQpVmHMJbH1pQdazWodWyyzJx8lBDXOeQB4UYRr443YdyE0VsZCJYlnJGJZM9t
         nO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8YEpYyj+slhz80KqGdO/dNLOYREGdFcjwe/TeO35Nn0=;
        b=d9LixUjuCspM57VxAgoSS/sahQ7A05Z3Iti496fePj34gMzq7HgzMeoec3QVmp/Yj8
         NHtecfr6TTd0iD9gEPrmgAY7e2xDZmkH861ydDFhLQRlblGXj+RB6cJBXQ/ebbg1tFKv
         EvKmkkowbUmKE65aMrhPXwYSQOODQ4+pPI0rGuHz8hYUiw5oF2CkVyk94cNdLsLyolcr
         SqT5tZ7Phqp6m2gp/OH5IpQyc7t1gcPj5Vu/vd9zli54ZmbmnKsxm7YppSraYX0PEEG9
         okanWhaJNS8pa/6DjBiDcXSaumeps4c/DXkbh4iYhBioNiO+IqfPsecqsgg460iNp7Ra
         ERJA==
X-Gm-Message-State: AOAM531xeNxEIsBfy4RtbtE1RX1dPdvVhrxMOfmZx2jXlJ7l+e6ldEqH
        27TrBSyqFsd/7cPOB1XEfd79hw==
X-Google-Smtp-Source: ABdhPJzwQW9JTfeuyhyO4h6CRamftv/UtuecNNRSZTQxoT1PjH95vAAtCdHqu4vgaSQjn3F9T0Vp0g==
X-Received: by 2002:a05:6214:29ee:b0:441:230a:e424 with SMTP id jv14-20020a05621429ee00b00441230ae424mr30942158qvb.2.1648650901167;
        Wed, 30 Mar 2022 07:35:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id b82-20020ae9eb55000000b0067b314c0fedsm11582372qkg.42.2022.03.30.07.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 07:34:59 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nZZPW-008rin-K4; Wed, 30 Mar 2022 11:34:58 -0300
Date:   Wed, 30 Mar 2022 11:34:58 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     mpenttil@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        apopple@nvidia.com, jhubbard@nvidia.com, rcampbell@nvidia.com,
        vbabka@suse.cz
Subject: Re: [PATCH v6] mm/hmm/test: use char dev with struct device to get
 device node
Message-ID: <20220330143458.GM64706@ziepe.ca>
References: <20220330004725.13428-1-mpenttil@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220330004725.13428-1-mpenttil@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 03:47:25AM +0300, mpenttil@redhat.com wrote:
> From: Mika Penttilä <mpenttil@redhat.com>
> 
> HMM selftests use an in-kernel pseudo device to emulate device private
> memory. The pseudo device registers a major device range for two pseudo
> device instances. User space has a script that reads /proc/devices in
> order to find the assigned major number, and sends that to mknod(1),
> once for each node.
> 
> Change this to properly use cdev and struct device APIs.
> 
> Delete the /proc/devices parsing from the user-space test script, now
> that it is unnecessary.
> 
> Also, deleted an unused field in struct dmirror_device: devmem.
> 
> Signed-off-by: Mika Penttilä <mpenttil@redhat.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> ---
> v6:
>         - remove device names array
>         - check return value of dev_set_name()
> v5:
>         - fix whitespace
>         . delete unused structure field
> v4:
>         - fix commit log
> v3:
>         - use cdev_device_add() instead of miscdevice
> v2:
>         - Cleanups per review comments from John Hubbard
>         - Added Tested-by and Ccs
> 
> 
>  lib/test_hmm.c                         | 13 ++++++++++---
>  tools/testing/selftests/vm/test_hmm.sh |  6 ------
>  2 files changed, 10 insertions(+), 9 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
