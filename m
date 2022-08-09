Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4C858E325
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiHIWWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiHIWWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:22:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1ACAA5D0C2
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 15:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660083765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J5d/3BG2s8vMnjAuoCduflI1NT5l+CFjuPlkuPIekQ4=;
        b=ZBTqCZhzK/VGqa3plYSRvgkuNKDpgqx55hQ8xP1HWWZagoPkuJjpGvcZFgjAV7EYHgjioN
        1xs/1DrZ9XQ18sHwjnKSSBW5zkrfLptSEAkcOKMRqF56LvkehpjC9Gdp5AV7Dxdbj8jAl/
        EKK6EAukwbfmO+eDmGdOPYj7LC+YGaY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-526-LOsvwJlnMFesVAXtERAgrw-1; Tue, 09 Aug 2022 18:22:44 -0400
X-MC-Unique: LOsvwJlnMFesVAXtERAgrw-1
Received: by mail-wm1-f72.google.com with SMTP id a17-20020a05600c349100b003a545125f6eso153063wmq.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 15:22:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=J5d/3BG2s8vMnjAuoCduflI1NT5l+CFjuPlkuPIekQ4=;
        b=6Xgrx7vZkmLyTozo4kX+ATBKLBSkqlmnymmfgrTtTPSU6ckFDjJj6VfJmtz8LNhBEF
         Sf7aiL9IWvRQIFttvyc9ITBKm0qmo9W5ws5ReuFOzJAsSCTv/6MvfPyRLDY2JBsE5zrp
         lww/wZKF+4DtDKs6LBKFbLq9AHmBc15xuCexfv9rG4xTcU41H6KmG3k4t0uKR6zY+Q2T
         cjNhil4BNQIn+IBIyjo9CgUCvfARSb8Z5yubYpONkrywrzSKIn2W4TIz6OHmLOoV3+Wg
         IJYJbnpdu8RnYYpH6ZCH/8c4yfbzNQPJAbysdVjY/w9s5ehCYJy7rJyuCp6pkhePJT5X
         tL3w==
X-Gm-Message-State: ACgBeo2knbNyfhzM4VSFSfmdNnROK+RIWHX8Cjwkz6wumC8rra9iyrY0
        y7jz3hff37gnpM9CjLDuPqODtrRFTGngbe7tx9AGNQZugK0LbOvSkblqmT9fdoHWtqxtRebVjRP
        RamN0nDeZ6JUn9Uy7t9J9XNS+
X-Received: by 2002:a7b:c2a9:0:b0:3a4:f2a8:e7e4 with SMTP id c9-20020a7bc2a9000000b003a4f2a8e7e4mr302183wmk.55.1660083762775;
        Tue, 09 Aug 2022 15:22:42 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4kBbpAEN6yiWnogwaGnmyCFzjP3Rldih06PHvfx/pIR7xi/W68poKipCx4qbM6a5cpTN/uuQ==
X-Received: by 2002:a7b:c2a9:0:b0:3a4:f2a8:e7e4 with SMTP id c9-20020a7bc2a9000000b003a4f2a8e7e4mr302175wmk.55.1660083762522;
        Tue, 09 Aug 2022 15:22:42 -0700 (PDT)
Received: from redhat.com ([2.52.152.113])
        by smtp.gmail.com with ESMTPSA id 5-20020a05600c028500b003a3278d5cafsm242111wmk.28.2022.08.09.15.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 15:22:41 -0700 (PDT)
Date:   Tue, 9 Aug 2022 18:22:38 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-bys missing for commits in the vhost tree
Message-ID: <20220809181520-mutt-send-email-mst@kernel.org>
References: <20220810080139.71f67609@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810080139.71f67609@canb.auug.org.au>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 08:01:39AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Commits
> 
>   2d84b3963557 ("ack! tools/virtio: drop phys_addr_t typedef")
>   c6d14c52fba9 ("ack! tools/virtio: drop phys_addr_t typedef")
> 
> are missing Signed-off-bys from their author and committer.
> 
> Is this new set of commits really ready and destined for the current
> merge window?

Oh sorry.  They are empty, they just record that I need to add an ack to
the log of the previous commit. So harmless - I just forgot to squash
them - I would normally notice as I prepare the pull request.
Fixed - if you can pick up the new hash I just pushed pls do but
if not it's okay to test as is, too.

-- 
MST

