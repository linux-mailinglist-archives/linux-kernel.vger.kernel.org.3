Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E435253F2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 19:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357201AbiELRng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 13:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353035AbiELRnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:43:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87F95E743;
        Thu, 12 May 2022 10:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GDncwLKphn/XZKopA1l8aEKODmu6Bj+8jDWkzig0Mlc=; b=v5VORm6ydKBJVYTVx2qzPm0X4n
        YQfDJBSgMcZYJuWgHmve2wHpzkb0hCvcXqAo7doJHNBfw7BwNSzleBoKEu3ZRjnsyEO8TmQseSYpr
        jr6EOX90POYPE6pFppucFilLWH3RLL3yef5L5pSGRsAOvN7Wr6z/XSKq2UXVdUq4w4/JS2Ho1+eK1
        YNvheGtOLSp8qWZsMMcHYnt8JKjGs2Xjk51K8yQrNQxUqezHKSoAhP8aCL8XnptqeifSCgzwREEdH
        NK4AimkTNmKo7O8d4Eq1S7YBMIwMHCw+jzLHNDyN8/AcO44bQ3FuND+JbHuJ6xsqZWnyc3vTkbeb1
        fKhOzEKA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1npCqT-00D1fT-5d; Thu, 12 May 2022 17:43:25 +0000
Date:   Thu, 12 May 2022 10:43:25 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        fnovak@us.ibm.com, linuxppc-dev@ozlabs.org,
        christophe.leroy@csgroup.eu
Subject: Re: request_module DoS
Message-ID: <Yn1HPSvyT4kAW7I/@bombadil.infradead.org>
References: <YnXiuhdZ49pKL/dK@gondor.apana.org.au>
 <874k1zt0ec.fsf@mpe.ellerman.id.au>
 <Ynk9j6DQmVGAA3Jf@bombadil.infradead.org>
 <Ynvl6wCQRFdYsHar@bombadil.infradead.org>
 <871qwz8aot.fsf@mpe.ellerman.id.au>
 <87v8ub6jk1.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8ub6jk1.fsf@mpe.ellerman.id.au>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 10:07:26PM +1000, Michael Ellerman wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
> > Luis Chamberlain <mcgrof@kernel.org> writes:
> ...
> >
> >> Can someone try this on ppc64le system? At this point I am not convinced
> >> this issue is generic.
> >
> > Does your x86 system have at least 784 CPUs?
> >
> > I don't know where the original report came from, but the trace shows
> > "CPU 784", which would usually indicate a system with at least that many
> > CPUs.
> 
> Update, apparently the report originally came from IBM, so I'll chase it
> up internally.
> 
> I think you're right that there's probably no issue in the module code,
> sorry to waste your time.

It gives me testing happiness to know that may be the case :)

  Luis
