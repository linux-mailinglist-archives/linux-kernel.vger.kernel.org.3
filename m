Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95FC54A217
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 00:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236181AbiFMW3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 18:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbiFMW3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 18:29:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BE5BAE43
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 15:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655159372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N9slvxSG8yuHf5LjsS6/OHnxn9VuKQYSBmJtKIsodrQ=;
        b=TjRM9LR4WC3YlE8PD2X3jJdNx1EnExzaqP037+4HgLHzVT0fByLT7mBbeNJbK2KZCQYPnB
        a6u/c/eS9OByf40OaHNmIRQ59ZD7Z+Ev4SX/dULjLP9mNr+13qdW9PfCDrhGG9TR1lAFsm
        rXhJ8r5f6WO1JLpyryJ+6zzrQCraH1U=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-185-QFu9VMAmM_eLI2VTaPPoRg-1; Mon, 13 Jun 2022 18:29:31 -0400
X-MC-Unique: QFu9VMAmM_eLI2VTaPPoRg-1
Received: by mail-io1-f70.google.com with SMTP id k5-20020a6bba05000000b00668eb755190so3393697iof.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 15:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N9slvxSG8yuHf5LjsS6/OHnxn9VuKQYSBmJtKIsodrQ=;
        b=mMqj5ZzECrMwSnSwPPJaFIuH9UHyroxAsG5FU6WK5bssInzJeLVveJ4eop55m1I8JK
         7l2ut7EPGiqHIXZ5bnFGJRRMKNMfcO1cy+D3/HA70QWNs5isPlTmrYVH++ZeA/TQv0ht
         9IQ0uK4jjroutDck+f764kn9UTjHtOkFDoFytd9gWqWGoyvHvL/lCT+xX3EzVEPFzkkR
         ig+pyzOWAo7qajtDsy40vOp23MhcHexnzCzf8QgvjPLeoHiEPCR5ndkB613DaV/AJ0BG
         ejgphViqV+0W8TRx3i3tnr9G8qsowA5+96h2jCzxTqce7waNvm6j2pTLCXS2QCsiEnEy
         mC8g==
X-Gm-Message-State: AOAM5335NHb50b5jZOVcb5mBluRIlYnebGnD5sAjY/irVl9y/uG4al1V
        HI8GC3507AO1fRoxtKliDdZLUaTk7bH7bp5frkqhyy/7FZhXhOIr+htHdEt7/ANQ7vwc3FfKoph
        eq3dC6lhaspr6OF5oOFuKOE0R
X-Received: by 2002:a05:6602:2d0e:b0:64f:d1ff:ac9c with SMTP id c14-20020a0566022d0e00b0064fd1ffac9cmr999338iow.41.1655159370930;
        Mon, 13 Jun 2022 15:29:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYuLiEIgEbDCMpfZ5G5MofdrV4wPXivgDYQrkwahKK9C4xyx5BABua4comPb9o8kU9eTD8mQ==
X-Received: by 2002:a05:6602:2d0e:b0:64f:d1ff:ac9c with SMTP id c14-20020a0566022d0e00b0064fd1ffac9cmr999316iow.41.1655159370649;
        Mon, 13 Jun 2022 15:29:30 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id k26-20020a02661a000000b0032e22496addsm4041331jac.139.2022.06.13.15.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 15:29:29 -0700 (PDT)
Date:   Mon, 13 Jun 2022 18:29:27 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Charan Teja Reddy <charante@codeaurora.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhangyi <yi.zhang@huawei.com>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 2/6] userfaultfd: add /dev/userfaultfd for fine
 grained access control
Message-ID: <Yqe6R+XSH+nFc8se@xz-m1.local>
References: <20220601210951.3916598-1-axelrasmussen@google.com>
 <20220601210951.3916598-3-axelrasmussen@google.com>
 <20220613145540.1c9f7750092911bae1332b92@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220613145540.1c9f7750092911bae1332b92@linux-foundation.org>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 02:55:40PM -0700, Andrew Morton wrote:
> On Wed,  1 Jun 2022 14:09:47 -0700 Axel Rasmussen <axelrasmussen@google.com> wrote:
> 
> > To achieve this, add a /dev/userfaultfd misc device. This device
> > provides an alternative to the userfaultfd(2) syscall for the creation
> > of new userfaultfds. The idea is, any userfaultfds created this way will
> > be able to handle kernel faults, without the caller having any special
> > capabilities. Access to this mechanism is instead restricted using e.g.
> > standard filesystem permissions.
> 
> The use of a /dev node isn't pretty.  Why can't this be done by
> tweaking sys_userfaultfd() or by adding a sys_userfaultfd2()?
> 
> Peter, will you be completing review of this patchset?

Sorry to not have reviewed it proactively..

I think it's because I never had a good picture/understanding of what
should be the best security model for uffd, meanwhile I am (it seems) just
seeing more and more ways to "provide a safer uffd" by different people
using different ways.. and I never had time (and probably capability too..)
to figure out the correct approach if not to accept all options provided.

I think I'll just assume the whole thing is acked already from you
generally, then I'll read at least the implementation before the end of
tomorrow.

Thanks,

-- 
Peter Xu

