Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3A45B2120
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbiIHOsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbiIHOsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:48:05 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985C18B991
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 07:48:04 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-127dca21a7dso17660016fac.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 07:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=lSCvYP5GkkFE/+kNRE5IPPJh8HdX91H33mYQbcBG7nU=;
        b=rIfhIX0oxp8JbmMS4OUarcv8cscy7ucPnQm8yTkAfZJBh3oyZkiP/ojKWEian62UT6
         HEk9DUU58mM5qYqh7H2UM043goBFPweEN+9FsGxypThYP3zF0+wGoTArpWOMkJUBxibo
         EPsZ34a6P4+xPNZOiKId3m5W5DFOBDSlu8PcU9TyVZNa5QyiFiNAWkNX+0HIR3i7Do7G
         0ScaL6lYh3aX7p2XuSo7uImOJsGeJ8EO3Kn0juPjJmLN/VNMZIUAQ+4aAqhTNiivGrKy
         uEVG0iklAS4L/cKeZoLfdZe89/I205eCjSaCdBigSFvSwf/rtEX7BenIEraWUN8c7HAR
         bTyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=lSCvYP5GkkFE/+kNRE5IPPJh8HdX91H33mYQbcBG7nU=;
        b=EUL0kZu+NS1t+05vNf6J1aB3GafYA37tlA5ZUzyru0bzzppG2q7BN2V9MyL6j2uKfQ
         xYmX84RTVBMgfioL/QLpQhWXUnLPAUEmiMo+0Nun7JN/pMUr4AIbBqa7Di/mkdgIlEME
         tK7q6QUV1iX8TV8jj1P2DlDnqwqqnFxOaL5wq8DcbEUmCtQHflffAmsk16FZtTXXKLtj
         mVnCWDu/QISw5Px9epkGFMV6oNkhqI0Oe9Li5a8Q9rJ1xzIoGIZNusjejRPy/fS0fhw0
         ZjuZvBeAqYgoUWUO4ok3vXQVzxRkkFY20daiqGeYHbse3OIkhLwM5Sh8r0OlGot7Ui8c
         kjpQ==
X-Gm-Message-State: ACgBeo1lWq6IaMWKpEOAIZpcwI9zuH37DodV34XgOlGcBv8lFEbD8455
        b9xdmNkfb2XpkJPGKADQ3cXhqrgoBNEEfMdjlTwF
X-Google-Smtp-Source: AA6agR5HGQfp8RzkswEJIrC2RMiCNEMYt1x7RD0oqKtb6IO9/u4zY/regFUnz296PCkGhAsrIkEp+U9cTrPuPeK20yw=
X-Received: by 2002:a05:6871:796:b0:11e:b92e:731e with SMTP id
 o22-20020a056871079600b0011eb92e731emr2158188oap.41.1662648483823; Thu, 08
 Sep 2022 07:48:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220907121230.21252-1-vincenzo.frascino@arm.com>
 <f1cefdb9-363a-c938-f02a-851173431610@infradead.org> <CAHC9VhQytyFMvq-M0YrqzKxJDyj58KKG0XDjBfTV02sYCzeALQ@mail.gmail.com>
 <Yxl614jNUYvYywUc@kernel.org>
In-Reply-To: <Yxl614jNUYvYywUc@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 8 Sep 2022 10:47:53 -0400
Message-ID: <CAHC9VhTHGX8160x8BC5cLQPQmn8QDyng6+FvsM4X=ca47CbWBQ@mail.gmail.com>
Subject: Re: [PATCH] security/keys: Remove inconsistent __user annotation
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 8, 2022 at 1:17 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> On Wed, Sep 07, 2022 at 11:43:17AM -0400, Paul Moore wrote:
> > On Wed, Sep 7, 2022 at 10:06 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> > > On 9/7/22 05:12, Vincenzo Frascino wrote:
> > > > The declaration of keyring_read does not match the definition
> > > > (security/keys/keyring.c). In this case the definition is correct
> > > > because it matches what defined in "struct key_type::read"
> > > > (linux/key-type.h).
> > > >
> > > > Fix the declaration removing the inconsistent __user annotation.
> > > >
> > > > Cc: David Howells <dhowells@redhat.com>
> > > > Cc: Jarkko Sakkinen <jarkko@kernel.org>
> > > > Cc: Paul Moore <paul@paul-moore.com>
> > > > Cc: James Morris <jmorris@namei.org>
> > > > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > > > ---
> > > > Note: This issue was discovered during the porting of the linux kernel
> > > > on Morello [1].
> > > >
> > > > [1] https://git.morello-project.org/morello/kernel/linux
> > >
> > > FTR, I have sent this same patch 3 times.
> > > Good luck.
> >
> > David or Jarkko, this patch is both trivial and obviously correct,
> > please merge this into the keys tree for the next merge window else
> > I'll take it via the LSM tree.
> >
> > Reviewed-by: Paul Moore <paul@paul-moore.com>
>
> I picked it to my tree.

Thanks Jarkko.

-- 
paul-moore.com
