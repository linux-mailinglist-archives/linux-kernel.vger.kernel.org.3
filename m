Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAC3504A9D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 03:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235666AbiDRBn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 21:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235676AbiDRBnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 21:43:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 092D01836E
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 18:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650246045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=js3VMr6f+ww/wTyt0zXjSjPTLatJCvLXjxHWV+1RMnE=;
        b=LMQj6u90tbOSTew9KqJ4UpcRVqu03gYsIr2RSvxP5/gOKtItNEXdvGmeQBgJu2VQyVht2j
        SO57+4qQCcSonzPnylZZHaF8XLnDLX+ycZboilyEWm+l8RHU2fg/R6Xs0x9J0X7xWENSoY
        uLw1g3dpNsz4cL5kgH85p366h8DfOgo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-498-Bzp9SVxpPSClpvqTJHACFA-1; Sun, 17 Apr 2022 21:40:42 -0400
X-MC-Unique: Bzp9SVxpPSClpvqTJHACFA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8115D833961;
        Mon, 18 Apr 2022 01:40:41 +0000 (UTC)
Received: from localhost (ovpn-12-21.pek2.redhat.com [10.72.12.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AB4944047296;
        Mon, 18 Apr 2022 01:40:40 +0000 (UTC)
Date:   Mon, 18 Apr 2022 09:40:36 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Coiby Xu <coxu@redhat.com>
Cc:     kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Mimi Zohar <zohar@linux.ibm.com>, Chun-Yi Lee <jlee@suse.com>,
        stable@kernel.org, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/4] kexec: clean up arch_kexec_kernel_verify_sig
Message-ID: <YlzBlPWXWeg6ABen@MiWiFi-R3L-srv>
References: <20220414014344.228523-1-coxu@redhat.com>
 <20220414014344.228523-2-coxu@redhat.com>
 <YleYmZAAnF5aOan3@MiWiFi-R3L-srv>
 <20220415093735.74eusyuuboa32aqs@Rk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415093735.74eusyuuboa32aqs@Rk>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/15/22 at 05:37pm, Coiby Xu wrote:
> On Thu, Apr 14, 2022 at 11:44:25AM +0800, Baoquan He wrote:
> > On 04/14/22 at 09:43am, Coiby Xu wrote:
> > > Currently there is no arch-specific implementation of
> > > arch_kexec_kernel_verify_sig. Even if we want to add an implementation
> > > for an architecture in the future, we can simply use "(struct
> > > kexec_file_ops*)->verify_sig". So clean it up.
> > > 
> > > Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
> > > Cc: stable@kernel.org
> > 
> > It should be not worth noticing stable kernel that a clean up patch need
> > be back ported.
> 
> Thanks for the suggestion! For the 2nd and 3rd patch, I'll add prerequisite
> info,
> 
> Cc: stable@kernel.org # 34d5960af253: kexec: clean up arch_kexec_kernel_verify_sig
> 
> and
> 
> Cc: stable@kernel.org # 34d5960af253: kexec: clean up arch_kexec_kernel_verify_sig
> Cc: stable@kernel.org # 83b7bb2d49ae: kexec, KEYS: make the code in bzImage64_verify_sig generic
> 
> respectively.

That sounds good, thx.

