Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707524AB00E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 15:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243162AbiBFOpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 09:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbiBFOph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 09:45:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED158C043183
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 06:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644158735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CH0OWcXnRkrjgrCYXVT/t1v7cfdo23G2D1dLRWzwJxk=;
        b=cqMEdtWl92deT1ocafFua67NZniUYSCHAyP95ihMMhfjxXHiUXwA/rIoBF+m3dxw0vIdNX
        QSo9tzr2CGnVGABMNjaALYIVQL9jYN6tTywEqv5MZlhFL1LqURQmUvfzHncxWqj3HzJHlr
        E1eaBSLVEToNREa1rtd79BRXDwG8G2E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-JeVKA7KKM6OQ1dODVfDZyQ-1; Sun, 06 Feb 2022 09:45:34 -0500
X-MC-Unique: JeVKA7KKM6OQ1dODVfDZyQ-1
Received: by mail-wm1-f69.google.com with SMTP id 130-20020a1c0288000000b0037bc5cbd027so439640wmc.8
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 06:45:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CH0OWcXnRkrjgrCYXVT/t1v7cfdo23G2D1dLRWzwJxk=;
        b=N0+133OVWtZB3boRsSV0t12gRsA6MpYDIFYVTQbGs9gVmA6ZG2r5Df8Vx3gZksT/rd
         9EqIuAefj6aQbNl6KmCwoYI7qr2bnIgG8f6IXv47zT3JQoZQtgaXrrmt429j6MfWQ8gW
         wo14oZvKyWG++25fhbUOaeNL6WCH91uX7VRSvPjKl0WY6hQTV5ALpVyamABajfNI6SO1
         9UzYkChBYxinsUqm9+n63ZvoDCI1kmk4bMe3444OJYxxwlMXibxhAirpobzLyfaWcynF
         ajHonpGrqq5KI8OsUvutOtgNA2O8LXu/RNmCUDe2bYcBsSEjnEfu0RooccKvL4VhhjSF
         Z8Hw==
X-Gm-Message-State: AOAM530BQHb6r5C4gdJuPkZHCmrRRaMfcIhfwWpwJ6YyjSkkBjUK6K97
        pV9/OWAJ876zAzePr5nV/t0PHESXqe1esgwisXPXFG3L9e/HIenkgESvOPONhGe4rVahr4r2edu
        EKIauTIykbSZDMDYZIt9EU48=
X-Received: by 2002:a7b:c109:: with SMTP id w9mr5994541wmi.118.1644158733673;
        Sun, 06 Feb 2022 06:45:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxhVXuM05zPsQbFNQ6KgmTUd3qNI7Oc/pZQt1LG4yuxaUGPKGMhRbsUz+3ZndnHcYmWWvT0vA==
X-Received: by 2002:a7b:c109:: with SMTP id w9mr5994534wmi.118.1644158733557;
        Sun, 06 Feb 2022 06:45:33 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id o29sm5890498wro.47.2022.02.06.06.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 06:45:33 -0800 (PST)
Date:   Sun, 6 Feb 2022 14:45:32 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Michal Suchanek <msuchanek@suse.de>,
        "cl@linux.com" <cl@linux.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "live-patching@vger.kernel.org" <live-patching@vger.kernel.org>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "ghalat@redhat.com" <ghalat@redhat.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "void@manifault.com" <void@manifault.com>,
        "joe@perches.com" <joe@perches.com>
Subject: Re: [RFC PATCH v4 00/13] module: core code clean up
Message-ID: <20220206144532.wbei7fn77fqrpk5j@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220130213214.1042497-1-atomlin@redhat.com>
 <Yfsf2SGELhQ71Ovo@bombadil.infradead.org>
 <30f0da92-17b0-4130-20d1-9fea8b81cdbc@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <30f0da92-17b0-4130-20d1-9fea8b81cdbc@csgroup.eu>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-02-03 07:48 +0000, Christophe Leroy wrote:
> All function prototypes in header files are pointlessly prepended with 
> 'extern' keyword. This was done that way in the old days, but has been 
> deprecated as this keyword does nothing on function prototypes but adds 
> visual pollution when looking at the files.

Christophe,

Firstly, thanks for your initial feedback.
I will address the above.


Kind regards,

-- 
Aaron Tomlin

