Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB705A3E29
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 16:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiH1Oon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 10:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiH1Ool (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 10:44:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0B72E9EA
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 07:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661697879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hTdmiB22wnq3dmvK7RjNhZhCqkVHrOk+1i/pQcMS7HE=;
        b=eW5tbmvtJqF1lHOcx8vnpRVVu3txzDKjBK7euUbRClUmlgZUk0fBrXA6IY7y1OyOBvTK4/
        22Yo0GyxiaKIyO38Zcc5Ae7STqjpp6USTo7MPt49E3juKqKZTkR1d/DLxvQdKNOfmDtP3w
        Yl5S/ZMABDzkZy12PBvd9kHUpzj0bBc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-_VW9_-tSOkiUcRiPCEVYfA-1; Sun, 28 Aug 2022 10:44:36 -0400
X-MC-Unique: _VW9_-tSOkiUcRiPCEVYfA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8858F1C051AF;
        Sun, 28 Aug 2022 14:44:35 +0000 (UTC)
Received: from localhost (ovpn-12-25.pek2.redhat.com [10.72.12.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DD2B94C816;
        Sun, 28 Aug 2022 14:44:32 +0000 (UTC)
Date:   Sun, 28 Aug 2022 22:44:28 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Christophe Leroy' <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 01/11] mm/ioremap: change the return value of
 io[re|un]map_allowed and rename
Message-ID: <Ywt/TB0rsKWrFcVy@MiWiFi-R3L-srv>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-2-bhe@redhat.com>
 <d5272f42-f3e3-b2a8-428e-bd7815cf7518@csgroup.eu>
 <YwQdRg/IS0+3tbNu@MiWiFi-R3L-srv>
 <a4a9ba6f-9891-cc4c-e512-d221141d998f@csgroup.eu>
 <YwTu1kzcIUxsTL4j@MiWiFi-R3L-srv>
 <429cb367-923f-bb3d-ccf0-57dce0c7f35b@csgroup.eu>
 <b193efbff3a74343839c3dee1702f73c@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b193efbff3a74343839c3dee1702f73c@AcuMS.aculab.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 08/24/22 at 08:16am, David Laight wrote:
......
> > >>>> Le 20/08/2022 à 02:31, Baoquan He a écrit :
> > >>>>> In some architectures, there are ARCH specifici io address mapping
> > >>>>> handling when calling ioremap() or ioremap_prot(), e.g, arc, ia64,
> > >>>>> openrisc, s390, sh.
> > >>>>>
> > >>>>> In oder to convert them to take GENERIC_IOREMAP method, we need change
> > >>>>> the return value of hook ioremap_allowed() and iounmap_allowed().
> > >>>>> Meanwhile, rename them to arch_ioremap() and arch_iounmap() to reflect
> > >>>>> their current behaviour.
> > >>>
> > >>> Thanks for reviewing.
> > >>>
> > >>>>
> > >>>> Please don't just say you need to change the return value. Explain why.
> > >>>
> > >>> The 1st paragraph and the sentence 'In oder to convert them to take
> > >>> GENERIC_IOREMAP method' tell the reason, no?
> > >>
> > >> What I would like to read is _why_ you need to change the return value
> > >> in order to convert to GENERIC_IOREMAP
> > >
> > > I rephrase the log as below, it's OK to you? Or please help check and
> > > tell what I need to improve to better explain the reason.
> > >
> > > ====
> > > The current io[re|un]map_allowed() hooks are used to check if the
> > > io[re|un]map() actions are qualified to proceed when taking
> > > GENERIC_IOREMAP way to do ioremap()/iounmap(). Otherwise io[re|un]map()
> > > will return NULL.
> > >
> > > On some architectures like arc, ia64, openris, s390, sh, there are
> > > ARCH specific io address mapping to translate the passed in physical
> > > address to io address when calling ioremap(). In order to convert
> > > these architectures to take GENERIC_IOREMAP way to ioremap(), we need
> > > change the return value of hook ioremap_allowed() and iounmap_allowed().
> > > With the change, we can move the architecture specific io address
> > > mapping into ioremap_allowed() hook, and give the mapped io address
> > > out to let ioremap_prot() return it. While at it, rename the hooks to
> > > arch_ioremap() and arch_iounmap() to reflect their new behaviour.
> > > ====
> > >
> > 
> > That looks more in line with the type of explanation I foresee in the
> > commit message, thanks.
> 
> I think you also need to summarise the change itself.
> If the success/fail return actually changes then you really
> need to change something so the compiler errors unchanged code.
> Otherwise it is a complete recipe for disaster.

Thanks for looking into this and sorry for late response.

I am not sure if I follow you. In this patch, I just rename the old
ioremap_allowed() to arch_ioremap(), and change its return value. Except
of arm64 which has taken GENERIC_IOREMAP way to provide
ioremap_allowed(), no other ARCHes are affected yet. This is what have
been changed. Could you be more specific what I should add?

Or are you suggesting words like below sentences need be added to patch
log?

If the success/fail return actually changes then you really
need to change something so the compiler errors unchanged code.
Otherwise it is a complete recipe for disaster.

Thanks
Baoquan

