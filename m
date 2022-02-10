Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE424B0A1A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 10:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239245AbiBJJ7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 04:59:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239236AbiBJJ72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 04:59:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB798BD3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 01:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644487169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BfA2iFJwMibzGsqNn5V+xr5t8qyVpCn8grTyfArw+wQ=;
        b=ajclnqaffIT8SqKK5iI3+tAVcvKgSopvZ4wPPYlVYbeRTMdq2mrVFFAup3Lnm4QReE+fnW
        YZSe60ejS1dwaiobRhXb7sv56Ajs9Q7YljpM3Xook8UXwHFB5uaUAaZbq+Ui+Lkx0Flwvs
        6PiMN9P8b2itTC4K1s4uEyA6j4ClnGk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-82-IHoQ7g-aPHC1NYWbjkKWJA-1; Thu, 10 Feb 2022 04:59:27 -0500
X-MC-Unique: IHoQ7g-aPHC1NYWbjkKWJA-1
Received: by mail-wr1-f72.google.com with SMTP id e1-20020adfa741000000b001e2e74c3d4eso2257006wrd.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 01:59:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BfA2iFJwMibzGsqNn5V+xr5t8qyVpCn8grTyfArw+wQ=;
        b=uFXJ6jug+3eQVC5XHSje9oqrpayz+C76ordh/gBJ8qnAW29m8KNlXDmnEopLc3KoRp
         vHMiD5txUlnFeUzYltOh+fumCFGnm6iDwHZDbYHDGu+PllSG+uxSsVQk2o2YowQrlJQa
         Ah6DVWWh5K2Oc/B0X+cFHGxrWuJfdjtNrL5+IbBX+xYwThQ/aZpo9ZuKG0d/IlD/PrCE
         782b+E7MSarl3nt/XNNH/aFFXDRTfl/YUSCJZrBO5+8fHnK8y5tpzENQOE4Ow6wPT1GD
         fj7uo/h/T82/a/SEk+7kg/s/0SFk0CqTkfZJ1GUoVerG66IdE5xMx2Z+cs3Ga4BBgvET
         YCbQ==
X-Gm-Message-State: AOAM530ezokLgZOOY0TiwUt3qKojQuFlLsvYVG53n/kj6wCs4wG3Etue
        6w7sES6aawJmHtmjaVhygyvO7oTIloNt8FlASWRUse98+4ZRRoe8codTb7R+JX9g7LKgUaUB0ZQ
        xzQOZH5DuRqm+cZ+mMePrY/A=
X-Received: by 2002:a5d:5481:: with SMTP id h1mr5673405wrv.386.1644487166545;
        Thu, 10 Feb 2022 01:59:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzBv2nKwftCzNCsKkaPwuBvX4on6VNzrk0X7Gfq2MKiJkchFNnOAzOMhkypUYzMlfiwR/kKrA==
X-Received: by 2002:a5d:5481:: with SMTP id h1mr5673395wrv.386.1644487166349;
        Thu, 10 Feb 2022 01:59:26 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id h17sm990687wmm.15.2022.02.10.01.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 01:59:25 -0800 (PST)
Date:   Thu, 10 Feb 2022 09:59:25 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc:     20220209170358.3266629-1-atomlin@redhat.com, mcgrof@kernel.org,
        cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        live-patching@vger.kernel.org, atomlin@atomlin.com,
        ghalat@redhat.com, allen.lkml@gmail.com, void@manifault.com,
        joe@perches.com, christophe.leroy@csgroup.eu,
        oleksandr@natalenko.name
Subject: Re: [PATCH v5 07/13] module: Move extra signature support out of
 core code
Message-ID: <20220210095925.qa2wk5ec6e5vlkvl@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220209170814.3268487-1-atomlin@redhat.com>
 <20220209204812.GD3113@kunlun.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220209204812.GD3113@kunlun.suse.cz>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-02-09 21:48 +0100, Michal Suchánek wrote:
> This reverts a97ac8cb24a3c3ad74794adb83717ef1605d1b47

Hi Michal,

Oops! I'll address this.


Thanks,

-- 
Aaron Tomlin

