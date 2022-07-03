Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F81A564817
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 16:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbiGCOZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 10:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbiGCOZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 10:25:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C737962EE
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 07:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656858299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vt8sM7P6c/5KQFjfgPv9CeGYHkTEe+4ULo2jY/ipBlM=;
        b=jB51pb03sSgiMkb2NKxIMWhKse2kT9Dgp2ntE18vb2/1Meu1R1xspGx1XHiAf0WXCAmaNK
        vLlGL1f6bWuywbHtcBpUuesb5zpi4XuElxRlXaMNuynJqBUKha3+v9Fh2p0ssQlH/M2hKR
        sGTh3+vYI+tdNFDuPKrd4sujFaLVoXc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-491-MbS5cPz7N4KYLWnKUzw2Vw-1; Sun, 03 Jul 2022 10:24:58 -0400
X-MC-Unique: MbS5cPz7N4KYLWnKUzw2Vw-1
Received: by mail-wm1-f69.google.com with SMTP id m17-20020a05600c3b1100b003a04a2f4936so4077183wms.6
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 07:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vt8sM7P6c/5KQFjfgPv9CeGYHkTEe+4ULo2jY/ipBlM=;
        b=ulXlkyFACSbMyeQZjNiph1o1p/8LynhLBjEJk5wyr/YMZ5T22qbcujmFTpcTvC6wwC
         kpIV61aTAFudOOr76dXBz3KZi81WT0gwARbuzfAC8YG7ongqbQYA4ptavRT9XsiuD5Np
         iIEAroKh3DAxgrNg4BJBirpKGMmQVYQ0eS3wcOzVp4Dh916L0icf24s2qOXYkybQ3TeJ
         NksKKuNOkkcMq+VOY+vQL/Q+ZyUthrY1AofwGNLe4uT2rJTY8Za9d3itQA/TrloFkElg
         f65kHjtyRAudVJi+NJ6/bekZ2CzpD5Mp32Ulv/TO3PoXZ415IggThKLd67j/s1GOO41a
         z8yQ==
X-Gm-Message-State: AJIora/eTAE720HfWLBcYRk0ZnRvl0xr/Q2Tb0FlhtKOGvIxPZ9qnKu0
        rHWodbNc7nsHJYkacL7OkN9mI4M6zjgyJV7OR3UUc1jAjcbUq6C3FRlDEhz0Oyz7yzuRbIa3nbV
        tgWfOknp7oLLJMwHa/JodxlE=
X-Received: by 2002:a05:600c:4e46:b0:3a0:4d54:f206 with SMTP id e6-20020a05600c4e4600b003a04d54f206mr29360656wmq.151.1656858297686;
        Sun, 03 Jul 2022 07:24:57 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uSeMKHEu9k5bVj3/yIEKGl1d5sksubHwC6uSi0vcAI9vvGDGmnLmVofg9HMfsQtPic3cf+SA==
X-Received: by 2002:a05:600c:4e46:b0:3a0:4d54:f206 with SMTP id e6-20020a05600c4e4600b003a04d54f206mr29360640wmq.151.1656858297516;
        Sun, 03 Jul 2022 07:24:57 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id 13-20020a05600c020d00b0039c362311d2sm14933620wmi.9.2022.07.03.07.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 07:24:56 -0700 (PDT)
Date:   Sun, 3 Jul 2022 15:24:56 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, christophe.leroy@csgroup.eu,
        cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com,
        daniel.thompson@linaro.org, hch@infradead.org,
        Chuck Lever III <chuck.lever@oracle.com>
Subject: Re: [PATCH v11 09/14] module: Move kallsyms support into a separate
 file
Message-ID: <20220703142456.l6mwruh6jvwjvq4k@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220310102413.3438665-1-atomlin@redhat.com>
 <20220310102413.3438665-10-atomlin@redhat.com>
 <20220628000526.11c57cd8@gandalf.local.home>
 <20220628081906.jln2ombfej5473xi@ava.usersys.com>
 <Yr92YtG12f+II+ea@bombadil.infradead.org>
 <20220703083324.az24ou7nrngvp73v@ava.usersys.com>
 <20220703092305.1e5da4c2@rorschach.local.home>
 <20220703135708.kn535pdrqv24f7kn@ava.usersys.com>
 <20220703101344.59710a42@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220703101344.59710a42@rorschach.local.home>
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2022-07-03 10:13 -0400, Steven Rostedt wrote:
> On Sun, 3 Jul 2022 14:57:08 +0100
> Sorry about being harsh. It's something that was engrained in me when
> doing kernel development, and something I found useful for all software
> development.

Not at all! I welcome the feedback :)

> Honestly, the hardest thing about kernel development is the review
> process. The easier we can make reviewing, the better the code will be.

+1


Kind regards,

-- 
Aaron Tomlin

