Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0225642C2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 22:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiGBUqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 16:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGBUqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 16:46:33 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2605A454;
        Sat,  2 Jul 2022 13:46:32 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id bs20so4560043qtb.11;
        Sat, 02 Jul 2022 13:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N+mq0Y7evuA/KRdL0BLthRO/Vn35FRdsKAND75BcEFY=;
        b=AUGeP9V+3E+lVbQ2IzhyK/D4WNZkXavbzjY+Vd9/o6cdIGFuf4vcfb5wBpIpPSD2U+
         nB/wM3DN8N6S4hFtfE+BlD2dXzMMWEAbJdOtoGORev06lsu2Dhhn+K25qPzmExM6suqk
         6VfONdRiHt5xou98e4Ln/rToVubtO2beeZ4zCzT8W2i8rws9MDya+fFXt31otZQ6PqfE
         RdEK4yjOmj51FeqFO/r2bNsLiliJaPqtmfvsL1K7T8aTNHum07O8b/xmEAIug6XyD27D
         CLDQmwnEYkiNJCk6ml2l8gLqUP+VB7q7NByfsX1m+aAPt39AheEr/8Yo/I7W/ahE5JgP
         sIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N+mq0Y7evuA/KRdL0BLthRO/Vn35FRdsKAND75BcEFY=;
        b=b2Q2sIT21DcBVrDJ/3Nl+kXgIG1EnhoK19pgzu2SCHI7HOeovYhPjXxA5xDTY7ukrJ
         Fglzz7dhaKurSLA0w2tFAS9KAF5kldEZgOHVswpFsTnVG0UMkSS8elEDXgV+WMJDBbAS
         BoqzL6V1PT5GbdURIGu64izoMkB7lFoIR4WbXDDjZ/p93AKIfpLIRoj8a05K92RHQ3z7
         cMeqqU8RifjiInTatuizg3Nrsg7/1bL50VMnK1bgXmgohVj7GCrAUL9NwOJNVipdKxgL
         hjSDcK3pVOxD5R6A7RK12yNBLni/OD/wqPF60fzLXXPTVoE1BU8icKaWnGnrvgks8c+e
         66EA==
X-Gm-Message-State: AJIora+WwjcCreMFRbrc3m28bhO8gSm8vjmHWrQhovzrBk+ZUfi9I0/R
        nkef+G86kb3fb19zzXJbICk=
X-Google-Smtp-Source: AGRyM1vjFgjitLBuQOeSuo/OKde0C2zCG2i7rCQmnsS9b/7NGq3EkHHEPjctpLsqsrGPdIjCur6S0A==
X-Received: by 2002:a05:6214:19cb:b0:470:8fae:eb90 with SMTP id j11-20020a05621419cb00b004708faeeb90mr21566832qvc.92.1656794792059;
        Sat, 02 Jul 2022 13:46:32 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:e838:b1c2:b125:986a])
        by smtp.gmail.com with ESMTPSA id r132-20020a37a88a000000b006af373cec2csm12713874qke.70.2022.07.02.13.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 13:46:31 -0700 (PDT)
Date:   Sat, 2 Jul 2022 13:46:31 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        vneethv@linux.ibm.com, oberpar@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        almaz.alexandrovich@paragon-software.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        linux-s390@vger.kernel.org, ntfs3@lists.linux.dev,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/4] s390/cio: Rename bitmap_size() as idset_bitmap_size()
Message-ID: <YsCup7Kjzm9QWeZ5@yury-laptop>
References: <cover.1656785856.git.christophe.jaillet@wanadoo.fr>
 <3f2ad7fb91948525f6c52e0d36ec223cd3049c88.1656785856.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f2ad7fb91948525f6c52e0d36ec223cd3049c88.1656785856.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 02, 2022 at 08:29:09PM +0200, Christophe JAILLET wrote:
> In order to introduce a bitmap_size() function in the bitmap API, we have
> to rename functions with a similar name.
> 
> Add a "idset_" prefix and change bitmap_size() into idset_bitmap_size().
> 
> No functional change.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/s390/cio/idset.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/s390/cio/idset.c b/drivers/s390/cio/idset.c
> index 45f9c0736be4..e1e77fe080bf 100644
> --- a/drivers/s390/cio/idset.c
> +++ b/drivers/s390/cio/idset.c
> @@ -16,7 +16,7 @@ struct idset {
>  	unsigned long bitmap[];
>  };
>  
> -static inline unsigned long bitmap_size(int num_ssid, int num_id)
> +static inline unsigned long idset_bitmap_size(int num_ssid, int num_id)
>  {
>  	return BITS_TO_LONGS(num_ssid * num_id) * sizeof(unsigned long);
>  }
> @@ -25,11 +25,11 @@ static struct idset *idset_new(int num_ssid, int num_id)
>  {
>  	struct idset *set;
>  
> -	set = vmalloc(sizeof(struct idset) + bitmap_size(num_ssid, num_id));
> +	set = vmalloc(sizeof(struct idset) + idset_bitmap_size(num_ssid, num_id));
>  	if (set) {
>  		set->num_ssid = num_ssid;
>  		set->num_id = num_id;
> -		memset(set->bitmap, 0, bitmap_size(num_ssid, num_id));
> +		memset(set->bitmap, 0, idset_bitmap_size(num_ssid, num_id));

We don't need bitmap_size() here, we need to replace memset() with
bitmap_zero().

>  	}
>  	return set;
>  }
> @@ -41,7 +41,7 @@ void idset_free(struct idset *set)
>  
>  void idset_fill(struct idset *set)
>  {
> -	memset(set->bitmap, 0xff, bitmap_size(set->num_ssid, set->num_id));
> +	memset(set->bitmap, 0xff, idset_bitmap_size(set->num_ssid, set->num_id));

Same, but bitmap_fill().

>  }
>  
>  static inline void idset_add(struct idset *set, int ssid, int id)
> -- 
> 2.34.1
