Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F975A8152
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 17:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbiHaPey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 11:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbiHaPet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 11:34:49 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103DB2DB
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 08:34:45 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id z29so11900765lfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 08:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=QmLsPIkzQeMZ0W9KEkX+jtoeNsShZZ/M3BTzlrg5hy4=;
        b=TEWtKYGYnoqrxifG2H4rHXJUlsC9vKGgse47bDIjRpSxja4JyspQMUAlPZx82s0MHg
         uAzv3f3lu8VE1INx8lQbq6PYwJm5GDjPn7ZP6WYDQmFX9n2WL93WVAJfSuYryQZX4aPd
         vpvq6jdWjFy8eu8YLRolLUjQCmfSUYu8MWWMGs+4efE59abc+kae98sofCosIOsULlKB
         zkFKaWg+GdZC8HoaRIi+7JcD6psARqLnvd7MpUjTXVtouW9Ed2Hgf9sjiWMjdYVgQShu
         zIbarokirj1HX/gJY7gEfNHrtjfikb3H/PbGLtxaXTqhkT1qdu5rq42/DzF5r4N6XBbH
         zt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=QmLsPIkzQeMZ0W9KEkX+jtoeNsShZZ/M3BTzlrg5hy4=;
        b=JJ0534nCLcqPsbTjo6BjPQT+0WiHmSiDNfaXa5S5Ams8WNPWILXloCVsRkx3ZG/OqE
         gDKnqGeLZkCUpr4gX61kwLD14cn5zmITLTYztu3LtUFIoxVh2YP7hi0cJLKZEYcTAAA0
         si15I2IGy8ngwbdwdJhUb9sW81qfLWxVF/PD8e0axzi5RkDiXfHpYjyYFfQn1gB/fUk1
         yIfHJwUWocfYTYlRwRdIaxPe00dBKFmchcizpE3kJmvHDNzGbcTATxsQnMTEi4qqfwNt
         ZcNYnUz5UavHei8FAbvX8e5ttbLzx4Af7WgRyVSuKjVDztk3RXGqQYbCB/gK3GAddevK
         IUqw==
X-Gm-Message-State: ACgBeo06jDnlelvR9XWOCTHp3XC9pk+VIkyVg8d46qtpaDjbu558vkat
        nQD4AWV/cZjyLyCUc1C5H44=
X-Google-Smtp-Source: AA6agR6+PpGwhDXm4m1+FvQwpvXnp7VU0YHQE+fdyNOmAcdLXz8gHSCdFrCKDi7Pg58EuF9Tw88mtA==
X-Received: by 2002:a05:6512:169c:b0:492:ca5c:eb23 with SMTP id bu28-20020a056512169c00b00492ca5ceb23mr10028402lfb.646.1661960083302;
        Wed, 31 Aug 2022 08:34:43 -0700 (PDT)
Received: from pc636 (host-217-213-139-9.mobileonline.telia.com. [217.213.139.9])
        by smtp.gmail.com with ESMTPSA id q18-20020a2eb4b2000000b00265757e0e66sm1159024ljm.48.2022.08.31.08.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 08:34:42 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 31 Aug 2022 17:34:39 +0200
To:     Baoquan He <bhe@redhat.com>, Song Liu <song@kernel.org>
Cc:     Song Liu <song@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, songliubraving@fb.com,
        Uladzislau Rezki <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm/vmalloc: Extend find_vmap_lowest_match_check with
 extra arguments
Message-ID: <Yw9/jzYgzFAwsDcy@pc636>
References: <20220831052734.3423079-1-song@kernel.org>
 <Yw8PvP/SjDCE6DDX@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yw8PvP/SjDCE6DDX@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 08/30/22 at 10:27pm, Song Liu wrote:
> > find_vmap_lowest_match() is now able to handle different roots. Make
> > similar changes to find_vmap_lowest_match_check() and
> > find_vmap_lowest_linear_match() to handle different trees.
> 
> Good catch. Guess usually nobody eables DEBUG_AUGMENT_LOWEST_MATCH_CHECK
> to trigger compilation of the code.
> 
> Reviewed-by: Baoquan He <bhe@redhat.com>
> 
I do it.

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki
