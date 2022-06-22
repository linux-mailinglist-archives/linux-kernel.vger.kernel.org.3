Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CC45549EE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241436AbiFVMZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 08:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236098AbiFVMZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 08:25:25 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409FB36155
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 05:25:17 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id i17-20020a7bc951000000b0039c4760ec3fso924528wml.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 05:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C8CokK5l88E+K1ZVN1mOI0JmAiwVZ2MGJj9DeLyRN9Q=;
        b=WdTHWZCobcprTtM8e5zjuxErzsh3ns/2th69gwXU9lWQTkx4lCY9Gzm1lpKJ6mXb5L
         hTk/TQd9dHEtrYHLAjYMdu0K9gUEixGLJfgvD1IwTXxEmzwUmdOt5Wp+bgbYmXHuC+mc
         d65955UpBZoPvRn0iocKNujXwLJIpKWCVUbYKTFTpCLPAQL4+X79Kn+FiIbI6uEHPPx1
         uPOa01YVp+qaSoLI/7umwATugMwLd2+zROZ/z9XxlAAO5xFcYfOICgwBxBFTMTKXZRP0
         SE8jMLE04vC7uSd9jWn9WaTtUgkXLvXWy5n4PYBxIg1+pvTKg9NUCcEWE4QSo8k2x04K
         ZTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C8CokK5l88E+K1ZVN1mOI0JmAiwVZ2MGJj9DeLyRN9Q=;
        b=2hRVvKG/aUTJDEGbKZY4vCGiGRU24T1RsFS854PeqqDTFolXoKkOsE2OF1/qiOFDGa
         CdJ0m//BemxMcM2fBEr/kNZSY7jDWe0zVHsYvONBT9xEatclmiGUmvpMLOCUca036dpC
         XxHtu38edxZIfGEaBQw3exH/IjOQvswOYaSSgPhk6HMwYjBrcTiEN3x6NGqO464z20SS
         Q/+eUQ053sOTVnB0+l9e3Z4CBboLSOw4ib/CEmvKhakvfeD6ieyMVYQi0TuG9tlxksPK
         2B3RS7fH4y7+O4SVyvxsJ7zhtyWGjNQXyVmQB5GU6f0cEKEV7XzIY8zvVhDn1W8NnYBO
         7H8g==
X-Gm-Message-State: AJIora+aha2fdauNwK5B8RmMHZx0/EfRSV2yMZH71pRbQVH95KX1Iye+
        G5pOCiHUTrhZXk3t4fQDjGU9wg==
X-Google-Smtp-Source: AGRyM1tluAHsky0HEv3bnsaxQ+bWaDhEdRneV3jeo/uwH9Su/9c66OHyJgWDTlsWJU8PclJWcAaH7g==
X-Received: by 2002:a05:600c:1f0c:b0:39c:600e:6d51 with SMTP id bd12-20020a05600c1f0c00b0039c600e6d51mr3593051wmb.3.1655900715834;
        Wed, 22 Jun 2022 05:25:15 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id t22-20020a05600c41d600b0039db7f1a3f5sm21011234wmh.45.2022.06.22.05.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 05:25:15 -0700 (PDT)
Date:   Wed, 22 Jun 2022 13:25:13 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Kate Hsuan <hpa@redhat.com>, Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH v1] staging: r8188eu: an incorrect return value made the
 function always return fail
Message-ID: <YrMKKdvNqhydcBBY@equinox>
References: <20220620085413.948265-1-hpa@redhat.com>
 <5396e576-0fbe-430c-d983-a2f4b1569f09@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5396e576-0fbe-430c-d983-a2f4b1569f09@lwfinger.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 09:05:17AM -0500, Larry Finger wrote:
> 
> The "for now" part is that Phillip plans to get rid of _FAIL and _SUCCESS,
> and replace the logic with a normal 1 for fail, etc.; however, this will be
> a major change that must be done carefully.
> 
> In any case NACK for this patch.
> 
> Larry
> 
> 
>

Hi all,

I would be happy to work on purging _FAIL and _SUCCESS from the driver
by all means - definitely a worthwhile goal. I know Pavel said he
might take a look too though - copying him in therefore to see if we can
coordinate an approach - happy to do as much or as little as desired.

Regards,
Phil
