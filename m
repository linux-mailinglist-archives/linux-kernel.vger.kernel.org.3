Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08019580A3C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 06:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbiGZENr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 00:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbiGZENo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 00:13:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 272BB20BD6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 21:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658808823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5lntECexEyNpXWdt23OJngoZd0SrPa0OPt4d0XLP3io=;
        b=MveN5yd+bL36HXwrOrpRVHH9zEicdU+YgFCXzCSCwJKb2doJbAcOrUxnYis1HtyLLcip0a
        z4uiUhlznLltX9v2yzwQszIMpAixbosVKeFhDB0sD+r8G6iZaI9fzJxfRYxllpOyo+f+KV
        swW4O4WrvJ5uUx1WOtkLALsFSECO6zs=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-wzxAoYM8MBqkME_FPMpRHw-1; Tue, 26 Jul 2022 00:13:39 -0400
X-MC-Unique: wzxAoYM8MBqkME_FPMpRHw-1
Received: by mail-qk1-f200.google.com with SMTP id x22-20020a05620a259600b006b552a69231so11259202qko.18
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 21:13:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5lntECexEyNpXWdt23OJngoZd0SrPa0OPt4d0XLP3io=;
        b=TFGmRdJ2VHgI5XOain8tRwzK8UuszYr0Yn5TckRzPXANdBplgmNMXWNpsdEeZEwz5i
         YzEyJ+f4blQTT1YtRMb5gPfNM2tZ+agmlabUyn4GCX2tjTtIGCIL7Pe10OkMUFTP1b0d
         uUin0uNU6S16LtULas169+UXxcCQ0gzD9ksDLix3HoRsl//BGlFA73QLbAgIAAd5Zu5e
         XfCuok2kJuO9Pd27/VKgE/S8tMUf8OgxyGShIO0O+eaxWsEbyXlFtiSeHOwGkwgQ/u25
         E0OjtsXFDegW8ht8XdPiGr4Sl1v5FITAkdgQLCnRZqvd4DREaGlniLwYH+YjkVWNY3A8
         rx4g==
X-Gm-Message-State: AJIora9X2yj5YS76cG72LAYXMOMK1LTYp9n3zqi01PplyO6xF+AS3Kf7
        SXHWT8px3r/Kvpv0luTcCOaAd08LadIz1cxE+jqGg5VIhf6mg9mqKJiajQ30Fjw+JaCHcM2BQCo
        znx8It4EZcsnP/NC75lSruwg=
X-Received: by 2002:a05:620a:2405:b0:6b6:1706:3bcc with SMTP id d5-20020a05620a240500b006b617063bccmr11435717qkn.92.1658808818852;
        Mon, 25 Jul 2022 21:13:38 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vt1Wg+374rShiULPVsZdaORIIEaTUiexr2fiXazKlx6twVcTzPKaaHpero0NwP8BXrP+CeSg==
X-Received: by 2002:a05:620a:2405:b0:6b6:1706:3bcc with SMTP id d5-20020a05620a240500b006b617063bccmr11435711qkn.92.1658808818639;
        Mon, 25 Jul 2022 21:13:38 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id i4-20020a05620a248400b006b59ddb4bc5sm10344597qkn.84.2022.07.25.21.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 21:13:38 -0700 (PDT)
Date:   Tue, 26 Jul 2022 00:13:37 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Mike Snitzer <snitzer@kernel.org>, linux-kernel@vger.kernel.org,
        Nathan Huckleberry <nhuck@google.com>, dm-devel@redhat.com,
        Sami Tolvanen <samitolvanen@google.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH 3/3] dm-verity: Add try_verify_in_tasklet
Message-ID: <Yt9p8VupWC0ZlFv4@redhat.com>
References: <20220722093823.4158756-1-nhuck@google.com>
 <20220722093823.4158756-4-nhuck@google.com>
 <Yt9KTzXUeA8xAiGv@redhat.com>
 <Yt9aGRXNNPGZFvld@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt9aGRXNNPGZFvld@sol.localdomain>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25 2022 at 11:06P -0400,
Eric Biggers <ebiggers@kernel.org> wrote:

> On Mon, Jul 25, 2022 at 09:58:39PM -0400, Mike Snitzer wrote:
> > 
> > > @@ -1156,7 +1217,7 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
> > >  		goto bad;
> > >  	}
> > >  
> > > -	v->tfm = crypto_alloc_ahash(v->alg_name, 0, 0);
> > > +	v->tfm = crypto_alloc_ahash(v->alg_name, 0, CRYPTO_ALG_ASYNC);
> > >  	if (IS_ERR(v->tfm)) {
> > >  		ti->error = "Cannot initialize hash function";
> > >  		r = PTR_ERR(v->tfm);
> > 
> > This hunk that adds the CRYPTO_ALG_ASYNC flag _seems_ unrelated.
> 
> I believe it's needed to ensure that only a synchronous algorithm is allocated,
> so that verity_hash_update() doesn't have to sleep during the tasklet.  It
> should be conditional on v->use_tasklet, though.

Ah yes, it is a mask, that makes sense.

I can now see why it was being set unconditionally given dm-verity's
optional ctr args aren't processed until after the crypto_alloc_ahash() call. 
And of course verity_parse_opt_args() depends on non-optional args
related to the tfm.... gah!

Do you have a sense for what the implications are for always setting
CRYPTO_ALG_ASYNC like Nathan had? Will it disallow certain tfm that
may already be in use by some users?

> > @@ -321,14 +320,12 @@ static int verity_verify_level(struct dm_verity *v, struct dm_verity_io *io,
> >  		if (likely(memcmp(verity_io_real_digest(v, io), want_digest,
> >  				  v->digest_size) == 0))
> >  			aux->hash_verified = 1;
> > -		else if (io->in_tasklet) {
> > +		else if (io->in_tasklet)
> >  			/*
> >  			 * FEC code cannot be run in a tasklet since it may
> > -			 * sleep.  We need to resume execution in a work-queue
> > -			 * to handle FEC.
> > +			 * sleep, so fallback to using a work-queue.
> >  			 */
> >  			return -EAGAIN;
> > -		}
> 
> 
> Doesn't this need to be:
> 
> 			r = -EAGAIN;
> 			goto release_ret_r;

Yes, good catch.

Thanks,
Mike

