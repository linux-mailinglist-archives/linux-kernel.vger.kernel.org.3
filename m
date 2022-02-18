Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C9B4BBC4A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 16:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237092AbiBRPiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 10:38:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236420AbiBRPiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 10:38:19 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EC63B6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 07:38:01 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id d11so6361213vsm.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 07:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KlximUQdmdZXnbPJfSZ8Lynpd+nv/zvxyZZuYYKSUXI=;
        b=g3upiXitzv9z8uQ7TM0hwJzfK03O6j1Vg+vHnquOztZoylzuCrPT0q4wrKL3WKZhB5
         IQsJ1+1/PaIJO7CoqzR+WPgOKQYg9UYu1qVbkG9u+v6kvjpbi7VIp76ro34h70ybylbB
         QH61m9wFRVPSZ9as4GZpO37wj8PUAc3sNbkkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KlximUQdmdZXnbPJfSZ8Lynpd+nv/zvxyZZuYYKSUXI=;
        b=F0TQC3V5KE9FpYWxcUMSgjinJdehGlcKf0ZQxHhNvY4y4cu54v2ZSFpdwSI+Govm11
         1hva06x0IEOVR9sFPcjHotEcfTkPBj6LPSMT9Z6s3/LRuNEepo6J0q55GlhL/a5HQ8vT
         Zjw7isAV7adNhHXd+BpMDAGdNrjNITlUIUV0FMeVR+goAfSmjz9J5qAtx3vB9d3Bqwr5
         MSA7VQgex5TLosM97pgbd7tUMgKxu72uJt8iLi6KpnYF7PItBJHqgnGbc1C5U2I9SYou
         cHgGOdcQrvfroek5Pbmtys7kFKhgHf1GQVLIAq/qAprfUspubuDFYkJSbP5CO2sCbAwE
         NSoQ==
X-Gm-Message-State: AOAM531TxcT2/Fm6v5qzzhV9K7MEoS2/3BWSOhvK6XJiljLW/VO4Xu4d
        fDYz6gIusjTJT7wjfRTPnKbWDjajuO9XpQleMPUHhg==
X-Google-Smtp-Source: ABdhPJw5OiV2XwmsRGvm4YmDdzaptihW/JaMJrgn06mbKEHHNTHIky4Tyyfh8C/lgnKpB9JFFMDq/S+RMzjSY2DHOSM=
X-Received: by 2002:a67:e0cc:0:b0:31b:d7bf:8403 with SMTP id
 m12-20020a67e0cc000000b0031bd7bf8403mr3828513vsl.61.1645198679465; Fri, 18
 Feb 2022 07:37:59 -0800 (PST)
MIME-Version: 1.0
References: <20220214210708.GA2167841@xavier-xps> <CAJfpegvVKWHhhXwOi9jDUOJi2BnYSDxZQrp1_RRrpVjjZ3Rs2w@mail.gmail.com>
 <YguspMvu6M6NJ1hL@zeniv-ca.linux.org.uk> <YgvPbljmJXsR7ESt@zeniv-ca.linux.org.uk>
 <YgvSB6CKAhF5IXFj@casper.infradead.org> <YgvS1XOJMn5CjQyw@zeniv-ca.linux.org.uk>
 <CAJfpegv03YpTPiDnLwbaewQX_KZws5nutays+vso2BVJ1v1+TA@mail.gmail.com>
 <YgzRwhavapo69CAn@miu.piliscsaba.redhat.com> <20220216131814.GA2463301@xavier-xps>
 <CAJfpegsQO-35p6uoG2ZfuCOLPFwnkbTcLc3K8r+HiS2un9au_w@mail.gmail.com>
In-Reply-To: <CAJfpegsQO-35p6uoG2ZfuCOLPFwnkbTcLc3K8r+HiS2un9au_w@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 18 Feb 2022 16:37:48 +0100
Message-ID: <CAJfpeguFUB_eqdE=CETE+mBhp0ZmeouoFeEs7=O5UibCmPi=CQ@mail.gmail.com>
Subject: Re: race between vfs_rename and do_linkat (mv and link)
To:     Xavier Roche <xavier.roche@algolia.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Feb 2022 at 14:37, Miklos Szeredi <miklos@szeredi.hu> wrote:

> One issue with the patch is nesting of lock_rename() calls in stacked
> fs (rwsem is not allowed to recurse even for read locks).

Scratch that, there's no recursion since do_linkat() is not called
from stacked fs.  And taking link_rwsem is optional for the link
operation, so this is fine.  For stacked fs the race is hopefully
taken care by the top layer locking, no need to repeat it in lower
layers.

I've now sent this patch with a proper header comment to Al.

Thanks,
Miklos
