Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50EA35A0077
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 19:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbiHXRez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 13:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiHXRew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 13:34:52 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B2BDEC9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:34:50 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id t140so11332126oie.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=iUc7iTn6xTAH7nh/o6yxXHdfKGNX4Z/5Jv6PbbsrmvE=;
        b=RlaeiBa5eL8zu0NgF7ARiV93OK31F7GkkyowxpdoTtVaIt6Yd6AwdmZeT4UhqxTOir
         TaQbTq0RY8Y6y+tGLDAhuRgnPvpdkEIOG/XPkwF4v5NCae8dReQI9E0ZTHaROIT2w45q
         f9sqGu0D99xgh/NvOUXrlPA/eOIMcCfk0srM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=iUc7iTn6xTAH7nh/o6yxXHdfKGNX4Z/5Jv6PbbsrmvE=;
        b=XkEB7LOGgjeau8RV4BVyTHlyhobMqdA3H/7PagQdQrl6RcFRAyp3GqxpQzoH6bXhrX
         tA7FwEtvpoXm1IlbnUiQEb/zxrDW1inSDwVLpCp1V7KqrYpiBclWqiTxvIlsEpG0AKKT
         K58ux2RVMiLg4+slGz5xN8qRpiPokfBsCld97unEhpIiFl+N7wQxrxnF0b+C1n5gaXyo
         0TBgTSR1oQtGOxMdoqqdXH08ZGLgXvNHNyLRiVUAD6u+npfq25Qwr0LJ62W8+iTxqZw7
         3TqlSEsv7kKHPCP1d0e9vIez5KsC+VDsnE+LjLWIBGGqKtfIqdd1YQQnZo9A4iunOO5l
         qbEg==
X-Gm-Message-State: ACgBeo15Q15/3K1Ooxn2aZq2GPSIrrpg66K2Oi6BnSIbnrz6jvgoLlC3
        6b8clqfmqwHe9uAVACTcySFDw25zLfIANw==
X-Google-Smtp-Source: AA6agR7LHTcEnGIMi49xA6vkJYP3zs5h3ctC3yatczaqeSQxWZyveJGROaFqPNepcjIzb8TnNAzB2Q==
X-Received: by 2002:a05:6808:130e:b0:344:f7a4:760 with SMTP id y14-20020a056808130e00b00344f7a40760mr108519oiv.83.1661362489660;
        Wed, 24 Aug 2022 10:34:49 -0700 (PDT)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com. [209.85.167.176])
        by smtp.gmail.com with ESMTPSA id t134-20020acaaa8c000000b0033ad6ea8d11sm4120607oie.47.2022.08.24.10.34.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 10:34:48 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id p187so12894930oia.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:34:47 -0700 (PDT)
X-Received: by 2002:a05:6808:3096:b0:342:ff93:4672 with SMTP id
 bl22-20020a056808309600b00342ff934672mr120785oib.174.1661362486729; Wed, 24
 Aug 2022 10:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220823222526.1524851-1-evgreen@chromium.org>
 <20220823152108.v2.4.I32591db064b6cdc91850d777f363c9d05c985b39@changeid> <YwYR/rzvrkvgZzBm@farprobe>
In-Reply-To: <YwYR/rzvrkvgZzBm@farprobe>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 24 Aug 2022 10:34:10 -0700
X-Gmail-Original-Message-ID: <CAE=gft48Tg6NnEUqfM-n1eOT3qa35dtowQGYCL3sbYBmr_Wm_w@mail.gmail.com>
Message-ID: <CAE=gft48Tg6NnEUqfM-n1eOT3qa35dtowQGYCL3sbYBmr_Wm_w@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] security: keys: trusted: Allow storage of PCR
 values in creation data
To:     list.lkml.keyrings@me.benboeckel.net
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Matthew Garrett <mgarrett@aurora.tech>,
        Jarkko Sakkinen <jarkko@kernel.org>, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        apronin@chromium.org, Daniil Lunev <dlunev@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 4:56 AM Ben Boeckel <me@benboeckel.net> wrote:
>
> On Tue, Aug 23, 2022 at 15:25:20 -0700, Evan Green wrote:
> > diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
> > index 0bfb4c33974890..dc9e11bb4824da 100644
> > --- a/Documentation/security/keys/trusted-encrypted.rst
> > +++ b/Documentation/security/keys/trusted-encrypted.rst
> > @@ -199,6 +199,10 @@ Usage::
> >         policyhandle= handle to an authorization policy session that defines the
> >                       same policy and with the same hash algorithm as was used to
> >                       seal the key.
> > +       creationpcrs= hex integer representing the set of PCR values to be
> > +                     included in the PCR creation data. The bit corresponding
> > +                  to each PCR should be 1 to be included, 0 to be ignored.
> > +                  TPM2 only.
>
> There's inconsistent whitespace here. Given the context, I suspect the
> tabs should be expanded to spaces.
>
> As for the docs themselves, this might preferrably mention how large
> this is supposed to be. It seems to be limited to 32bits by the code.
> What happens if fewer are provided? More? Will there always be at most
> 32 PCR values? Also, how are the bits interpreted? I presume bit 0 is
> for PCR value 0?

Makes sense, I'll pin down the specification a bit better here and fix
up the spacing.

>
> Thanks for including docs.

Thanks for looking at them!

-Evan
