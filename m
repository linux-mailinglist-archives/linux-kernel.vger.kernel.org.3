Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560AE4CBBA1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 11:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbiCCKo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 05:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbiCCKo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 05:44:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC4544707D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 02:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646304250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JprPZetbIa3gZelRValOQCvT2YcVAHIjq5tXKGeAvvg=;
        b=BHwJGfG44PmOkTa2V20R9sVGXfVTr3Q2X7yHKK9stdIFh2vbO2x785W2fk+Z7NeRcZIbkc
        82AHQhWyeo7cWSky633VF9KsuUX9H6Up6x/iKP6spTipCi5z5xeGhcJ8zB/JYSF8W4ILYN
        4vKCDlfDlKw+3sWAClFc+kYJfJqP+Bs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-262-W0Sa21xDNUWyLL5u4iXOlQ-1; Thu, 03 Mar 2022 05:44:08 -0500
X-MC-Unique: W0Sa21xDNUWyLL5u4iXOlQ-1
Received: by mail-wm1-f69.google.com with SMTP id bg33-20020a05600c3ca100b00380dee8a62cso1223475wmb.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 02:44:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JprPZetbIa3gZelRValOQCvT2YcVAHIjq5tXKGeAvvg=;
        b=hgQNAwt8J3LjyVtZx5TSSFd33e/uzayvPHfuMTI3+9Vz17qUf5BoL3waON3GMIp17K
         lujd6wKkshJ+KhVzQAI8KME20mOGpncucvC+odzNMm+cEcBkkFUMhdt7fISXWJ5j4sxt
         SA/dDyU7jrlyEzmyuRp8VemSKDva8xyHe3rOMjOA6ASG8NkyGDjyCTBaO4W4TYm2128c
         /J329Sfx4fwwjEPQ/FiQ8tplIcci8K1diC2l7yrSZUslHyQXaSixEbMsUN0pXZFvCcym
         O+afmNazJMDfrah39gsNZ3QeE+takryDqn/4G4kRY9VhiD9i7fqhJDfutV/L/ALaziWb
         xFOQ==
X-Gm-Message-State: AOAM533p+ha/hhBSYRwz19dNfEwUq+s7cn0hKchedf9IYZA1qroFDGOm
        E4wfhlsA8QuWBx9bki44jdkmlr60ZBOBAfUxZ2yp1FyH5VjEjXz7V8hmNF5Pa25MWcdJl+5SgJQ
        trQzueIVgd7MvUoiUsiuZfXM=
X-Received: by 2002:adf:f947:0:b0:1ef:9b55:7cba with SMTP id q7-20020adff947000000b001ef9b557cbamr15964001wrr.142.1646304246605;
        Thu, 03 Mar 2022 02:44:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxh9WCQeSpc3JiAKR09PprZtkHgEaKEjwnm3cnkYiHYbMin5c3oly+30gtLp/GKtHOUsxMucg==
X-Received: by 2002:adf:f947:0:b0:1ef:9b55:7cba with SMTP id q7-20020adff947000000b001ef9b557cbamr15963983wrr.142.1646304246425;
        Thu, 03 Mar 2022 02:44:06 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id l10-20020a056000022a00b001f017dfb5cdsm2135555wrz.90.2022.03.03.02.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 02:44:05 -0800 (PST)
Date:   Thu, 3 Mar 2022 10:44:04 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "cl@linux.com" <cl@linux.com>, "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "void@manifault.com" <void@manifault.com>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
        "jason.wessel@windriver.com" <jason.wessel@windriver.com>
Subject: Re: [PATCH v9 13/14] module: Move kdb_modules list out of core code
Message-ID: <20220303104404.crqt7oz4kydq36fo@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220228234322.2073104-1-atomlin@redhat.com>
 <20220228234322.2073104-14-atomlin@redhat.com>
 <20220302161917.gx5icfszakoye4uh@maple.lan>
 <20220302203153.3kcmwu662szf3drt@ava.usersys.com>
 <a87aac32-52b1-3d56-6331-1c241fea032f@csgroup.eu>
 <Yh/zy7FCcDmIdAn8@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yh/zy7FCcDmIdAn8@bombadil.infradead.org>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-03-02 14:46 -0800, Luis Chamberlain wrote:
> Since we are doing this to help with the cleaning this crap up
> the natural thing to do is have the code be a helper which only
> built-in code can use, so writing a helper starting with
> list_for_each_entry() which prints the modules out. I'm
> surprised we have no other users of this. There is nothing
> kdb specific about the functionality in that code. So it should
> just be moved.

Hi Luis,

Good point, albeit is it really worth it since the only external
user is kernel/debug/kdb/ code?


Kind regards,

-- 
Aaron Tomlin

