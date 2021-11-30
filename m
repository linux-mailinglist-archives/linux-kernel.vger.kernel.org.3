Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A499463EC1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 20:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhK3TqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 14:46:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:59257 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343565AbhK3Toh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 14:44:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638301276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TfrnItGdUTATVc7verTCm21aEuOKKR+WNjyNl2tTt/s=;
        b=HhMUcgqTu1uCnisBCrUOcZ2+FjDQSFFv0+VjOAx+G+VoPfpKEaUM9wzjG8GFt+YW9OgJBS
        LLr042Abls6PErA4a+ipS65v/nteIDwoyTAte0t7PfSaZ9JTB+EBkhGyEThuVVWgRhpy7W
        v29TqypplYsYNcWYykm1avEE3PhxSuQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-321-WaHTCL0jNDeHFQuISGGw6g-1; Tue, 30 Nov 2021 14:41:15 -0500
X-MC-Unique: WaHTCL0jNDeHFQuISGGw6g-1
Received: by mail-qk1-f199.google.com with SMTP id s8-20020a05620a254800b0046d6993d174so14643147qko.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 11:41:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=TfrnItGdUTATVc7verTCm21aEuOKKR+WNjyNl2tTt/s=;
        b=zg2O252Xy5CAUSdAVtHmsZspjLkLlIXrOwTtERQWEdZ7dHEkoCrmhDWPbSM2/zSu4T
         8XmjvGutr7Vjy2+dl2Rf4sIXIJbWOnA6oKZ4chxMSG86QTdjbkqyyR41Csw5EIlbKB4L
         MpOTeP+2cd6U6+DFt/KkKjOx3pMxRhx3l4G5Z5r4ybHUaniH7yFQVfSJ3JcMqKj2Aeu6
         knRdreDlFFS426jiN49nSlgTGcnQVyeVj8lEL88hAFvK1oH7/Sic1W/4TyViDopf96DO
         8AyJXZ5c/V0opeJfoMHwqdZlH1Kl1sT4Fv0JSOOsNI8b/4eNk70KsTdixKZ+sf0CBKnD
         ZLXQ==
X-Gm-Message-State: AOAM533GIItpFNifkgz+AJu9zIPaj7miB2TpUwtJ87OAGzhojmgzl9Me
        gCijUA+UnM08VCGvSF7f/XpVcqdTJMUBTOKLNuV9KpljnZxdET1ItHFonrzZCiY2xC8zPKFsoKs
        X5QJZJ+WKjdeTrORrQWtNMayC
X-Received: by 2002:a05:622a:1207:: with SMTP id y7mr1711719qtx.592.1638301274694;
        Tue, 30 Nov 2021 11:41:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwJ9+FRrK3xh+EE7L6zkfT/RZFYDXNc5DYJN863fnKtTH5CdGDV3FDUn0jq780tf4LLYhY8Og==
X-Received: by 2002:a05:622a:1207:: with SMTP id y7mr1711675qtx.592.1638301274513;
        Tue, 30 Nov 2021 11:41:14 -0800 (PST)
Received: from m8.users.ipa.redhat.com (cpe-158-222-141-151.nyc.res.rr.com. [158.222.141.151])
        by smtp.gmail.com with ESMTPSA id i6sm11067894qkn.26.2021.11.30.11.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 11:41:13 -0800 (PST)
Message-ID: <f4a4c9a6a06b6ab00dde24721715abaeca184a0d.camel@redhat.com>
Subject: Re: [PATCH v43 01/15] Linux Random Number Generator
From:   Simo Sorce <simo@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeffrey Walton <noloader@gmail.com>,
        Stephan Mueller <smueller@chronox.de>, Tso Ted <tytso@mit.edu>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Nicolai Stange <nstange@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Peter Matthias <matthias.peter@bsi.bund.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Neil Horman <nhorman@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Lavr <andy.lavr@gmail.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        John Haxby <john.haxby@oracle.com>,
        Alexander Lobakin <alobakin@mailbox.org>,
        Jirka Hladky <jhladky@redhat.com>
Date:   Tue, 30 Nov 2021 14:41:12 -0500
In-Reply-To: <CAHmME9p60Ve5XJTVcmGvSpUkg_hRp_i0rGG0R9VhuwLs0o_nXQ@mail.gmail.com>
References: <2036923.9o76ZdvQCi@positron.chronox.de>
         <22137816.pfsBpAd9cS@tauon.chronox.de> <YaEJtv4A6SoDFYjc@kroah.com>
         <9311513.S0ZZtNTvxh@tauon.chronox.de> <YaT+9MueQIa5p8xr@kroah.com>
         <CAH8yC8nokDTGs8H6nGDkvDxRHN_qoFROAfWnTv-q6UqzYvoSWA@mail.gmail.com>
         <YaYvYdnSaAvS8MAk@kroah.com>
         <ac123d96b31f4a51b167b4e85a205f31a6c97876.camel@redhat.com>
         <YaZHKHjomEivul6U@kroah.com> <YaZqVxI1C8RByq+w@gmail.com>
         <CAHmME9p60Ve5XJTVcmGvSpUkg_hRp_i0rGG0R9VhuwLs0o_nXQ@mail.gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-11-30 at 13:39 -0500, Jason A. Donenfeld wrote:
> On Tue, Nov 30, 2021 at 1:16 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > So unfortunately, as far as I can tell, Ted is not maintaining random.c anymore.
> 
> I am happy to step up here. Feel free to CC me on random.c fixes and
> I'll review them promptly.

Jason,
are you also volunteering to review the patches needed to reach
compliance with the NIST documents I mentioned in the thread?

Simo.

-- 
Simo Sorce
RHEL Crypto Team
Red Hat, Inc




