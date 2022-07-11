Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE37E570228
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiGKMfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiGKMfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:35:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BCC9E52FCA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657542920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H7KAcfgL+3uTfAwu8tPnvlKFuv060svC/kxgl3BoYMg=;
        b=NVPvphztMiJsGqJDuN4aYhHXkvIdNveuXP19mJRBgFu326SQ89M9fju/Oy03yqLnvBnsKo
        sBc4Z47ywXfuiLVnl9kTMfqi06RIbSBq69xwMfW2W2rTRYVpXM8FDCvpPmabXH8EUkbS6U
        JyJPGGIl6KAAVPKL4y4qd24j28+1x3g=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-JV99gAXLO52yS8Qmnb1Hxw-1; Mon, 11 Jul 2022 08:35:19 -0400
X-MC-Unique: JV99gAXLO52yS8Qmnb1Hxw-1
Received: by mail-ed1-f72.google.com with SMTP id b15-20020a056402278f00b0043acaf76f8dso2660697ede.21
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:35:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H7KAcfgL+3uTfAwu8tPnvlKFuv060svC/kxgl3BoYMg=;
        b=1wJ8lIT7bSUpyS07D5j9L/HxraxucjsCU+x43DIx4yoTIGavxO2QNgdCdKXO24s9Um
         GzL0oUuwc5+EtfZcwzfkgdt/7LcxfIRsVb3sETKd1gj9ijMcFbHovz1Y5Qkpjbcaf/np
         LWRTf+Y5KUD7voL/Ae3gpQOykmWEZpdJ0vf6RDDdHSRV7yrUN1bx1y6Eu+UoEkdlfoOV
         xxk6e62MWyYZxzfhCSP5XnohDXlzR6buPDP0AsNJLco4Zq/6S6n95nOo7Pk7GagRl0+i
         8y5crhFwHOufgxrKzV39NrBvzsDer8NHSsyh9cxGCwKYMGNc8KrfWeAl4YyizZi/h4v+
         28zQ==
X-Gm-Message-State: AJIora8zSzYBvgN4yCL0rDIX0sA6joOuUDkcvdgvorSSF/9v41HYnKou
        sneL86w0DrrRxBkDjLdJiOhvX2JkDZnZIrvVilwIXy1TEOST9+OJ2iEUmBMrUUYvHHhE9qcnPp0
        BYhEJE37kRdpm7ATRs/oXe6cs0fQ+0HlCSEhQKBle
X-Received: by 2002:a05:6402:3685:b0:43a:7c29:4284 with SMTP id ej5-20020a056402368500b0043a7c294284mr24455602edb.147.1657542918686;
        Mon, 11 Jul 2022 05:35:18 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tA4IE6wV3gqPyqEusKQlKlWmY8UwFoWpvGkBiB9DUDP3fZug/izgvxa0c/A2jFE49EpocJhGVFTdHXyuLx28Q=
X-Received: by 2002:a05:6402:3685:b0:43a:7c29:4284 with SMTP id
 ej5-20020a056402368500b0043a7c294284mr24455591edb.147.1657542918578; Mon, 11
 Jul 2022 05:35:18 -0700 (PDT)
MIME-Version: 1.0
References: <202207090803.TEGI95qw-lkp@intel.com> <YsvuJsjxEjp/LHZa@silpixa00400314>
In-Reply-To: <YsvuJsjxEjp/LHZa@silpixa00400314>
From:   Vlad Dronov <vdronov@redhat.com>
Date:   Mon, 11 Jul 2022 14:35:07 +0200
Message-ID: <CAMusb+QfUZwq+JRkUrOLGO7mQLZbg_ueFVo2_PTSiSRiq7BoEA@mail.gmail.com>
Subject: Re: [ammarfaizi2-block:herbert/cryptodev-2.6/master 45/53] htmldocs:
 Documentation/ABI/testing/sysfs-driver-qat:24: WARNING: Unexpected indentation.
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        "GNU/Weeb Mailing List" <gwml@vger.gnuweeb.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tomasz Kowallik <tomaszx.kowalik@intel.com>,
        Adam Guerin <adam.guerin@intel.com>,
        Fiona Trahe <fiona.trahe@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 11, 2022 at 11:32 AM Giovanni Cabiddu
<giovanni.cabiddu@intel.com> wrote:
>
> On Sat, Jul 09, 2022 at 08:23:35AM +0800, kernel test robot wrote:
...skip...
> > >> Documentation/ABI/testing/sysfs-driver-qat:24: WARNING: Unexpected indentation.
> >
> > vim +24 Documentation/ABI/testing/sysfs-driver-qat
> >
> >   > 24        Date:           June 2022
> I'm not able to spot what the issue is. Any suggestions?

Same here. I do not see what issue the test robot is reporting.

Best regards,
Vladis Dronov | Red Hat, Inc. | The Core Kernel | Senior Software Engineer

