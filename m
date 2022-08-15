Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC54059388C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 21:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242240AbiHOShg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 14:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243892AbiHOSgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 14:36:02 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BC23B97B
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 11:22:57 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id e8-20020a17090a280800b001f2fef7886eso7465229pjd.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 11:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=+KQg9NwkJDEhNpI4KkBdWQF+H9IGvkQatKSH56aORTM=;
        b=aW5T7Hd5uMAYJXCsCpBWdkbC0U2drOTIAyOdp3BpG0VKmoIKYFyV7tNa60PmPWnf3r
         Po25dpeQTWpvOeXxlJ497OWOlArjUKE+VomPurTwGVsLimUJVnRShSwYsBsqW+6Gkorr
         DO78OC7cEyyiuXHznxYvWSqcJknS3rZRTtP/Au8fejyCw3M6aq/9yf0EMy4syHXfZR8g
         ddILZu7Kax8/Vejz7j2lxntUTkc/n5zBfYEGZQTcxmAR+GYj5E8GcpzCntFonW1ReVVX
         5o8w8wqHyjmIb5S5cLAVkN24EAL6tWKaMvndI2bGmdhqB8eTBvMVqLVzVYS48Jt8P+Sh
         yBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=+KQg9NwkJDEhNpI4KkBdWQF+H9IGvkQatKSH56aORTM=;
        b=X+MiEmGQLBVZ+NZy5kj+W+0FvxejmJawzSHfvH+AVGkqLIPxEU2CZ3ZJJ6pAQfXpv6
         vZZtEpQUfbxvcitml7d/buaNzffe9adsEtEghrBCot9J0FaeSki7X+f+cvjr63W1iez2
         cqYTAbcvW3UTCqaWoIkwaQPzq5KeYLvXW/+4vMNevMmIH3mPX6UEqzFM/b59OD2+ecCt
         7itEATPflFjccLT6Z5/KMsvMZmn2a/mmiI4m9G/ZMQXyAZ2/VnsGP3gP+XIibOnRCN49
         UMq4nrTLjMCYYT4GRratZzIth1bfcRvsSlVT5vd86EBdh4dzm/nChqK1BI4Ls0RFPeay
         ojUg==
X-Gm-Message-State: ACgBeo0D3DNGHRk/n9C499W+GJvxsBPQuC57gMAvp7Zamg2YVlxqv4tZ
        LunQBZHLFkUK55opYd/Ir5HBZez/mHw=
X-Google-Smtp-Source: AA6agR7zxgKldb8Y65I25WjWdI4OtEONC4BxsVFPzFe+b0ylIX3azuU3hz1hjMCVeMvb4z1GPZZiLA==
X-Received: by 2002:a17:90b:3ecd:b0:1f5:6330:8295 with SMTP id rm13-20020a17090b3ecd00b001f563308295mr19253854pjb.174.1660587776259;
        Mon, 15 Aug 2022 11:22:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q19-20020aa79613000000b0052e78582aa2sm6804255pfg.181.2022.08.15.11.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 11:22:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 15 Aug 2022 11:22:54 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: upstream kernel crashes
Message-ID: <20220815182254.GA3241114@roeck-us.net>
References: <20220814212610.GA3690074@roeck-us.net>
 <20220815054117-mutt-send-email-mst@kernel.org>
 <20220815154920.GA4027315@roeck-us.net>
 <20220815120007-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815120007-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 12:01:56PM -0400, Michael S. Tsirkin wrote:
> 
> OK I think I will give it a day in next and then send it to Linus.
> Would be nice to know before that - vacation next week so I'd like to be
> reasonably sure things are nice and quiet and everyone can proceed with
> testing.

I ended up publishing several of the syzkaller reports because I could
not figure out how to test the proposed patch otherwise. Sorry for the
noise on the mailing lists, but I just could not figure out how to
trigger test runs without making the reports public. Various test runs
are now queued. Hopefully we should get results soon.

Guenter
