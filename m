Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6821B5725A7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 21:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbiGLTdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 15:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbiGLTdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 15:33:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE48E584D;
        Tue, 12 Jul 2022 12:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=UbUx/rxCyle+u1nzUr3TMX8RzT/9m20eYojWnqoh9UU=; b=AWXyeKKStfEDaqm8k1g/IlE2Dw
        m2NYIzBwp7ENVTSMfNCsSut5wuJc4TW1bsRKLzuiVXX86LjE54UASB4kM5bibud3Yu3vF21f4UWnz
        IfQQZQwG1brUPjGKcJfC3IcI8uJLqCQ4NtZMtoYjDHTGKp0m6/pCsAZ9CHw1k7dzmyVKJqofvCmsC
        zS8fH7Pz/J2r5VeQhcFcuIIn/qGFITsIRb+OevN3T288c/cQ6XqjY8v3PT7RU2ygnebqqt6jpLQdU
        S31a8TC+Qd9dmOYaOQjqR3heDvNXFxK7RzLX1qD2ikcmb/q5+zOQPk8tnLXXMJs0qWjwwihRYTY3s
        DSW2HhKw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBLGT-00E5Cu-Ve; Tue, 12 Jul 2022 19:09:45 +0000
Date:   Tue, 12 Jul 2022 12:09:45 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "atomlin@redhat.com" <atomlin@redhat.com>
Subject: Re: [PATCH] modules: move module symbols from init/Kconfig
Message-ID: <Ys3G+ZGr9k+2fTsx@bombadil.infradead.org>
References: <20220711162049.761342-1-mcgrof@kernel.org>
 <74dcc785-f3e7-6832-9af3-e0a0f69c58c9@csgroup.eu>
 <Ysx1C9IkJiFL+OH5@bombadil.infradead.org>
 <09f3ec9a-3a8e-d116-d38a-2fdb55f125c6@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09f3ec9a-3a8e-d116-d38a-2fdb55f125c6@csgroup.eu>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 05:57:35AM +0000, Christophe Leroy wrote:
> 
> 
> Le 11/07/2022 à 21:07, Luis Chamberlain a écrit :
> > On Mon, Jul 11, 2022 at 06:33:08PM +0000, Christophe Leroy wrote:
> >>
> >>
> >> Le 11/07/2022 à 18:20, Luis Chamberlain a écrit :
> >>> This moves all the module symbols from init/Kconfig to its
> >>> own dedicated file now that we have all of the module code in
> >>> its own directory.
> >>>
> >>> This does not introduce any functional changes.
> >>>
> >>> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> >>
> >> It is similar to the patch I sent in February, isn't it ?
> >> (https://patchwork.kernel.org/project/linux-modules/patch/4042712961d42186c449734c253511ea7076c780.1645543105.git.christophe.leroy@csgroup.eu/)
> > 
> > Sorry, I had missed that. Can you send a new v2 based on today's
> > modules-next? And I'll just drop my patch?
> > 
> 
> I sent out v2 rebased on today's modules-next 
> (c76654e22da1e0cb830bd0eb5832072fb76df358)
> 
> I see all my patches still have status 'new' in modules's patchwork 
> (https://patchwork.kernel.org/project/linux-modules/list/?submitter=192363).
> 
> Don't you maintain it ?

Yes but I never knew we used to have patchwork for modules, but glad we have
that now. Anyway all your patches are applied, is patchwork dumb to not
pick that up?

  Luis

