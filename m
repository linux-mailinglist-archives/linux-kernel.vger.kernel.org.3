Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B284AAFFE
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 15:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242916AbiBFOmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 09:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238787AbiBFOmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 09:42:06 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 06:42:04 PST
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D28EFC06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 06:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644158523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3xo75bD0PDOaBPfVsPyq+FCl95QCjNPeMKREfcTC2z4=;
        b=efz8rG+7/ITT9s1Lkghy9O0q0xI/r91YdqTh5VqpCzhRqRSufC0JyuGbaldPOCnDRL3TMb
        wHCqG7wvaopDYzreWQVHtpN6bu8G9HUXX4VL1AbdmFnSgrxp5djUrszyMlFWqXMgpudECo
        kbPAzQ9Blzc5//OyFYBdRVSgCVxe5kU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-SyTfKjVCMP2HAvU1tKDBcQ-1; Sun, 06 Feb 2022 09:41:00 -0500
X-MC-Unique: SyTfKjVCMP2HAvU1tKDBcQ-1
Received: by mail-wm1-f69.google.com with SMTP id h82-20020a1c2155000000b003552c13626cso6237853wmh.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 06:41:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3xo75bD0PDOaBPfVsPyq+FCl95QCjNPeMKREfcTC2z4=;
        b=NjRRmtNXlGz3pomLFcipkEuL0yB2ChK2TKlc/HOA1kSD+oF9z4IoP5ED/AHS3xPSu3
         IUPiYR1sXaxvnol/JT3H2bIYEbCAx2MJTks/CB1Ogq9J9usfedH18CMgEjQTN274btfP
         OBbywTK9TGEV72tlIvQ2KzK9h/knAvmmXFJ0Q3y3z7Vzbe88HTt7glWY7FE2KjfDHL7n
         9LUZegr1TBM8obCk9H+lkdi9lykLmQKe3oglu7Qh7n0ySqhO4H/RAecJgP9hcv+9RTLI
         9BYeCaJjl4105o7wEgRYYJW44tJ1udWnqTrmRDK8HH+PfUVIoI93uh3oAJ5h3ljFL0XM
         7j4g==
X-Gm-Message-State: AOAM532mREgqHYYs4fssDUEJoWkkWlrVAQ6/5Sp+UbETzZYlY30DVZoK
        t25U82jX5Us0fBEITwFIqZrOR93ktttNqkPW3YwIqYRwtUrcZyc1vpacIIdrhQP8g4S+SaShEKX
        BicRKLS+WWBXd8+m/bvYN10g=
X-Received: by 2002:a1c:6a11:: with SMTP id f17mr7307808wmc.183.1644158459546;
        Sun, 06 Feb 2022 06:40:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzm/kRptajKDTAh89yC1ciHnNdlI1yp9Czrsc5eMbNPyYfBFvivYGaNPSqesEaBuIRdpJvwwA==
X-Received: by 2002:a1c:6a11:: with SMTP id f17mr7307795wmc.183.1644158459401;
        Sun, 06 Feb 2022 06:40:59 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id p15sm834616wma.27.2022.02.06.06.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 06:40:58 -0800 (PST)
Date:   Sun, 6 Feb 2022 14:40:57 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        live-patching@vger.kernel.org, atomlin@atomlin.com,
        ghalat@redhat.com, allen.lkml@gmail.com, void@manifault.com,
        joe@perches.com
Subject: Re: [RFC PATCH v4 00/13] module: core code clean up
Message-ID: <20220206144057.sp4ldrxq2eqp5g4k@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220130213214.1042497-1-atomlin@redhat.com>
 <YfnwB0GkXln4KaGk@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YfnwB0GkXln4KaGk@bombadil.infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-02-01 18:44 -0800, Luis Chamberlain wrote:
> Nice, can you get this tested with 0day? You can ask for your tree to
> be tested, see:
> 
> https://01.org/lkp/documentation/0-day-test-service
> 
> See the question, "Which git tree and which mailing list will be tested?
> How can I opt-in or opt-out from it?"

Thanks for this information Luis.



Kind regards,

-- 
Aaron Tomlin

