Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08ECF525967
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 03:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376365AbiEMBac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 21:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355338AbiEMBa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 21:30:28 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E6E28ED3F;
        Thu, 12 May 2022 18:30:27 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id n10so6738305pjh.5;
        Thu, 12 May 2022 18:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=9X5kC6GteP9EBXJtzDeiqdmzeIzKu9v1oBp+SCCmeJY=;
        b=ifqp5w+jHC7YwAzRFFF8ELHZl9G5QlVzyNcwS7fx/+qChM+95vHtAHRqIbQowt2t8x
         fLxj/OM0F74uTJRtKKewYhokZsISCkBt57DD10IhXckY1B144k/RoduXIJnjQZ4P2jt2
         gob4Ki6PlJXdWWcK8Gw2Yk7gdDuNqx+IssdHT6HyJxaYk2Vs1WcOayc8oWhhU+h/UI71
         EYagHhNpnk6UdZgbl0lEiJPMmyV7dno2sUQBihfBH18KL9S/zJ+uisG1L6i0gL5etUEF
         8mKQ9j2tnUccNMhlG/m35837ind8gZnr1WBcbjpiuYM0bTsLTLEoPMZQqvwkcTsVDRY1
         YkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=9X5kC6GteP9EBXJtzDeiqdmzeIzKu9v1oBp+SCCmeJY=;
        b=RB/+LfAksmZ9Fmdk4Yrvnwbk298QphIdGFEVI4JIMYZK4eImBM6+P6hGO2+QDvXt3g
         pDd886lRazGD11Txx5zyeL7oq8fUwZBgsCH0h/MhIeR34lCn/8+eFbOaEe/i/nW7NxGw
         pvqqhFdtUSFiF+1j8IenTqg1aXuxzi4D9oBj9Ki1eDrEkns9l4jDZa9AJZSQUTFp2sB+
         5RjEnWlgO9myKkN4/UmwMAoeM9zQ0fJzHTDPZMMVmIORv0Um2FnhRTagasrPJDukoQfH
         wSzt6hG4DPJ1CUWFoVOPplnsV4oDhNMefVoBR0XZZH1u2x/tdJX6WQWN6rHdlVkfnQX6
         wVoA==
X-Gm-Message-State: AOAM530u5A2rohcfsbk3p36sGM6frgEdhc4lFIe04DTVhOUL51F4QGrC
        djoA4ZQCa+nzQrptrx4phRI=
X-Google-Smtp-Source: ABdhPJzAy4iRDR2p1r3xepO7V5UnT/Avo9YdFC2m9V88tNWA91tNn9GfP1rCqW31S8xlB/WFB2i+zQ==
X-Received: by 2002:a17:902:768a:b0:159:71e:971e with SMTP id m10-20020a170902768a00b00159071e971emr2469409pll.163.1652405427411;
        Thu, 12 May 2022 18:30:27 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id n22-20020a056a0007d600b0050dc7628139sm489560pfu.19.2022.05.12.18.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 18:30:26 -0700 (PDT)
Message-ID: <627db4b2.1c69fb81.6d1eb.1e81@mx.google.com>
X-Google-Original-Message-ID: <20220513013025.GA1630003@cgel.zte@gmail.com>
Date:   Fri, 13 May 2022 01:30:25 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     david@redhat.com, kbuild-all@lists.01.org, corbet@lwn.net,
        bsingharora@gmail.com, mike.kravetz@oracle.com,
        yang.yang29@zte.com.cn, sfr@canb.auug.org.au,
        thomas.orgis@uni-hamburg.de, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] delayacct: track delays from write-protect copy
References: <20220408103708.2495882-1-yang.yang29@zte.com.cn>
 <202204082220.1w5xTsNt-lkp@intel.com>
 <62748c65.1c69fb81.2aa2d.4a7b@mx.google.com>
 <20220505215706.dd5f27399d99ef53cfb9244c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505215706.dd5f27399d99ef53cfb9244c@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 09:57:06PM -0700, Andrew Morton wrote:
> On Fri, 6 May 2022 02:48:04 +0000 CGEL <cgel.zte@gmail.com> wrote:
> 
> >     I found this patch is first merged into linux-next, and dropped silently
> > without sending any mail. Could you please tell the reason? Thanks!
> 
> It's still in my tree, part of a small queue of post-linux-next patches
> which I'm not presently distributing.  I'll bring it back soon.

Thanks! I want to write some other patches base on this patch, so please
notify me when it back.
