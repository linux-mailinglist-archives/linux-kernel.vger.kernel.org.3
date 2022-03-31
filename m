Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865584ED251
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 06:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiCaET3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 00:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiCaESx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 00:18:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0096628E361;
        Wed, 30 Mar 2022 21:12:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C74160C66;
        Thu, 31 Mar 2022 02:58:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB7AC340F0;
        Thu, 31 Mar 2022 02:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1648695480;
        bh=1bvfiThee0tfMwL06GiQ3KTUBZtkZQn6o1lFExVrqDo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h6Bf7sLuGVVxS0o9LcX8augarAdxfWvVTaPw+3LTeFkr+c6mOBOY8KKJEAP6N6pt8
         SyIJCpdHm7EqsTFoGkhIZcVtvy7ILpeaSP/0dQMq8MaJ/uZ2SwgKDpoABzAdCfrfTK
         f6/NiQeO3XBjoBUgKMJyB03PFjNQLTMrREM+88tQ=
Date:   Wed, 30 Mar 2022 19:57:59 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Muchun Song <smuchun@gmail.com>
Subject: Re: [PATCH v6 1/4] mm: hugetlb_vmemmap: introduce
 STRUCT_PAGE_SIZE_IS_POWER_OF_2
Message-Id: <20220330195759.6da783a678229008ac2a6851@linux-foundation.org>
In-Reply-To: <CAMZfGtXsMZ7ZwAzV5yZ39TB-=Q7Lw8oyjq2m65SXqHGwHQfj9w@mail.gmail.com>
References: <20220330153745.20465-1-songmuchun@bytedance.com>
        <20220330153745.20465-2-songmuchun@bytedance.com>
        <20220330192827.4b95e3d7fb149ef9cc687ccb@linux-foundation.org>
        <CAMZfGtXsMZ7ZwAzV5yZ39TB-=Q7Lw8oyjq2m65SXqHGwHQfj9w@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Mar 2022 10:52:58 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> > > +int main(void)
> > > +{
> > > +     if (is_power_of_2(sizeof(struct page)))
> > > +             DEFINE(STRUCT_PAGE_SIZE_IS_POWER_OF_2, is_power_of_2(sizeof(struct page)));
> >
> > Why not
> >
> >         DEFINE(STRUCT_PAGE_SIZE_IS_POWER_OF_2, 1);
> >
> 
> Yep, this is more simple.  But the 2nd parameter of DEFINE() will
> go into the comments.  I want to make it more clear when someone
> reads the code of this macro.  The two different sentences will
> generate the following two different comments.  Which one do
> you think is better?
> 
> #define STRUCT_PAGE_SIZE_IS_POWER_OF_2 1 /*
> is_power_of_2(sizeof(struct page)) */
> #define STRUCT_PAGE_SIZE_IS_POWER_OF_2 1 /* 1 */

The former ;)
