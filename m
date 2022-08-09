Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C3A58D595
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 10:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241011AbiHIIne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 04:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiHIInc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 04:43:32 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF661DA61
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 01:43:32 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id t22so11082384pjy.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 01:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=elUvtuL2kVb/35W5CxmDRBxZyU1x7DcPOf19Y83reF8=;
        b=QhQXR+ze135sBCyHeBinXlq3LyTr23aiTe92VwEeK6+KGVzALtHtda+p/RExqhae65
         pK4Mr2JTOtRoXlsalpWX4nHOkidQgoOxrb0c2wvAKtIfeD1FQ6xtcYKe1lTDfJmLQ7r/
         dzyc/hvlG9nQmeJ11oxVFoJcUETNGeJBhqn5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=elUvtuL2kVb/35W5CxmDRBxZyU1x7DcPOf19Y83reF8=;
        b=1oFnKAthcn01QoxzQVbag4mg7oo5r49TPxCULdyhdKB0iEeHRGurA6oWDFcSeuodAe
         JSSQGZQrvBFIM3E2QXhsH9QAZrn6dEuHgcV2g24Pr17CzFRhwaqUFw6JlLVbwNPxzB5Z
         7YXorjgijpr6biKo794zxJ/Nu67pV4Ot/SDbrEXCrcy5egHsaHz+L2sPQXP81mKxf1Iq
         F0FUkruTjuu+TiGyB+V/r+qhDpUNzFb2gt5JvdImghc9HQ8HEnZXz+Uoyr/lyshVcyot
         UVeziZu9DmC6XkdwLTyn6830lch/Q4pvEoBlYihBEhzOZ2sRAmC66ijkR+Pzso5kMjjo
         RuVw==
X-Gm-Message-State: ACgBeo1QAdy31Rg2f3QacOttgrkKWKPgXX74hLM2ccP2uFooe0nFTFzv
        L1R4wdtwq6E1jVBR+CxP31c8kw==
X-Google-Smtp-Source: AA6agR4g0iwFDa0QJbX03zs/TLEaaO7TUnRNLsePA9PD0lvB9tHLC5g4XRozrNCPXb49cJlV+4DWqA==
X-Received: by 2002:a17:902:f60f:b0:16b:d172:4014 with SMTP id n15-20020a170902f60f00b0016bd1724014mr21921415plg.147.1660034611240;
        Tue, 09 Aug 2022 01:43:31 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:8d43:c739:457a:5504])
        by smtp.gmail.com with ESMTPSA id a4-20020a62d404000000b0052553215444sm10069448pfh.101.2022.08.09.01.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 01:43:30 -0700 (PDT)
Date:   Tue, 9 Aug 2022 17:43:24 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        minchan@kernel.org, ngupta@vflare.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jan Kara <jack@suse.com>, Ted Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        avromanov@sberdevices.ru, ddrokosov@sberdevices.ru
Subject: Re: ext2/zram issue [was: Linux 5.19]
Message-ID: <YvIeLHuEb9XDSp6N@google.com>
References: <CAHk-=wgrz5BBk=rCz7W28Fj_o02s0Xi0OEQ3H1uQgOdFvHgx0w@mail.gmail.com>
 <702b3187-14bf-b733-263b-20272f53105d@kernel.org>
 <c7c69f77-4ea2-3375-33f3-322a3d35def5@kernel.org>
 <8710b302-9415-458d-f8a2-b78cc3a96e49@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8710b302-9415-458d-f8a2-b78cc3a96e49@kernel.org>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/08/09 10:12), Jiri Slaby wrote:
> > So currently, I blame:
> > commit e7be8d1dd983156bbdd22c0319b71119a8fbb697
> > Author: Alexey Romanov <avromanov@sberdevices.ru>
> > Date:�� Thu May 12 20:23:07 2022 -0700
> > 
> >  ��� zram: remove double compression logic
> > 
> > 
> > /me needs to confirm.
> 
> With that commit reverted, I see no more I/O errors, only oom-killer
> messages (which is OK IMO, provided I write 1G of urandom on a machine w/
> 800M of RAM):

Hmm... So handle allocation always succeeds in the slow path? (when we
try to allocate it second time)
