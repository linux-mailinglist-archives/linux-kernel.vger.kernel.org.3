Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C51578C2C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 22:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbiGRUyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 16:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiGRUyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 16:54:45 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950622C672
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 13:54:43 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 8-20020a05600c024800b003a2fe343db1so8041954wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 13:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=76HER70lXocGM75xfzcfxhEnSxHKa8NBLYr5AFjTPBQ=;
        b=PRAVBlFcwdjB/iW69T2Z/NxmZ34sADPfWk8JReRwxAEJhxw5PioaeHJ14YOm7io5+4
         HNFsKx2kLa0ld6ot25xJVW/EZ54YzRsJqabw3D7mCAj+ZbXeXqRmZ5T41IvotsASL4AN
         voHlIORGZHHQyC8LYNGJ7UQPm5s5f5kmcsmjsh51d8vMcqW21gRVObu0kzEWMxzBynnE
         vmyb2I9QdF+ylN7QLPYDxSptJbG2mR70A7LMbvLirlkOvEBQBBit3zwJTdcLWnU9gLkg
         iLn+PheNDlym3iU/rx2Cu7Hhr+c67t9Hi85mkroJahJG718uu2dR8F3K4mmkJ17RSF2q
         g3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=76HER70lXocGM75xfzcfxhEnSxHKa8NBLYr5AFjTPBQ=;
        b=uBJaokiO9kODNz0EBx+Vz0DRkUliYQgni4Tb0S9TXH4MnFfHqwlkaSSCAomBXNJqmf
         8Wo7jRLy/0Sm4JtvOLK70EmdpQ4OSvY3bZVeptYzPmL5o3y0db1T66id/sazA6uj4HeM
         2gSg/8EM8qSwl2vd/EoYALP0Ve7JR0IC3hSELwqeGMyJ/voGNwHCB+XrxneyLlo8tmxG
         zqF7Qa5uWAXrdkUDjUVZh5VQ8742LGoH+MuKAHtECrb8rTdB5Uoqv+A6ONaeaRefx85o
         g6gpg8Cnmugv92V/0j75iLmI1q6HhspzgUKyh1MU44B5oJQvXzAmP09sNPNQZC6kRdgr
         wRbA==
X-Gm-Message-State: AJIora+j4UvymjETm8KvOx1WwbYm+5LeQCryjOHvRDjyS3+bpzfaQbyL
        zng0Mk4SX6Qr9oIa5MgZss0i2vu21Fc=
X-Google-Smtp-Source: AGRyM1sWmR5/muZESx9nlqUif+Vf9Iwnzlm0pDn1b3+ar56sdk0tPFE1vQkj8eerhMwmACoCeUETiA==
X-Received: by 2002:a05:600c:17d5:b0:3a3:576:21ba with SMTP id y21-20020a05600c17d500b003a3057621bamr19738045wmo.176.1658177682062;
        Mon, 18 Jul 2022 13:54:42 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id v192-20020a1cacc9000000b003a2cf1535aasm16200747wme.17.2022.07.18.13.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 13:54:41 -0700 (PDT)
Message-ID: <62d5c891.1c69fb81.cf50e.3d99@mx.google.com>
X-Google-Original-Message-ID: <YtXEjth7fwCaT3Xh@Ansuel-xps.>
Date:   Mon, 18 Jul 2022 22:37:34 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH] regmap: permit to set reg_update_bits with bulk
 implementation
References: <20220715201032.19507-1-ansuelsmth@gmail.com>
 <165815182610.53791.17547202213321860152.b4-ty@kernel.org>
 <62d564c7.1c69fb81.9010e.da70@mx.google.com>
 <YtVxPjzG2JrbPTKf@sirena.org.uk>
 <62d572ed.1c69fb81.c7f5e.a109@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62d572ed.1c69fb81.c7f5e.a109@mx.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 04:44:23PM +0200, Christian Marangi wrote:
> On Mon, Jul 18, 2022 at 03:42:06PM +0100, Mark Brown wrote:
> > On Mon, Jul 18, 2022 at 03:48:52PM +0200, Christian Marangi wrote:
> > 
> > > thanks, assuming everything went smooth with the merge to linux-next and
> > > no problems arise, can you provide a signed tag?
> > 
> > > This is needed for a net-next series that is currently in RFC state as
> > > it does depends on this.
> > 
> > > (I had this problem before and it was said that in this kind of
> > > situation I had to ask for a signed tag to merge the related patch in
> > > net-next branch)
> > 
> > Oh, it would have been good to know about this when reviewing the patch
> > rather than after the fact - since this hadn't been mentioned it's now
> > applied on the main development branch with everything that's going into
> > the next release rather than on a separate branch for easy merging
> > elsewhere.  How urgent is this, given that the merge window is likely to
> > open at the weekend so this'll get sent to Linus at that point - is the
> > driver otherwise near merging?
> 
> Ohh sorry, I was too generic in the patch comments and didn't mention it
> was an actual dependency.
> 
> It's not too urgent, (I assume) but it was said that it was preferrable
> to have the changes done in 2 weeks window (the one in net-next about
> the working driver). Will ask on net-next and give you news ASAP.
> 

Hi Mark,
sorry for the delay, I pointed out this problem with net-next and we
decided to adopt a workaround so this is not urgent anymore and we can
wait the merge window to have this change in net-next.

The required code will be updated later when this change is merged.

-- 
	Ansuel
