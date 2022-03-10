Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF704D435A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 10:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240738AbiCJJVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 04:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbiCJJVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 04:21:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4FE341390FC
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 01:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646904020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eE5u+28lhyoip/PQPaNK8ZMHNsTO3Mz2r3pYVpfkrPQ=;
        b=SvZJ8PKbXn7pfjVpA7LPibm6L6gjrVsLRh+pVZdPZbqDYgUQdZ4v8kzcPuQ9e3mcK23Pjw
        dYMKJmDFwvIqMEx6LyUGRT2KTYtLW7zWcxe9+tuDqbEJ60ok2S5xqaQyB70vtqXOH1Rs4l
        xI1McPu+dhWKIVU/29yzIDY094zM1RE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-656-P0WQUhKgMn6aQVXN5AeOKg-1; Thu, 10 Mar 2022 04:20:19 -0500
X-MC-Unique: P0WQUhKgMn6aQVXN5AeOKg-1
Received: by mail-wm1-f71.google.com with SMTP id 14-20020a05600c104e00b003897a167353so2037217wmx.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 01:20:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eE5u+28lhyoip/PQPaNK8ZMHNsTO3Mz2r3pYVpfkrPQ=;
        b=F4TVT2fvOULAp7cTvAgNAP353eJ1YTpWHd6kDic5QIS8xWTUxzp/LqqUoeOa60/eIc
         H2uoyfGJ1oSO0uRkD+29OLECGKliH3XhW28RR4hFNSzFp5CoU7PO86Bn+raiROAUfrzE
         X9fAn+iqM8nZds+T9BDaZSmqRr5pAjGolciST/RiL+aOqHnDXSizfGndkKtsbxph9nVd
         lSjGW5XfEcfsg1RYcsLmN0ZYU5koTHCyrnDVra6ty/utl4xZdXAVAx47dJbvMMJdX/2q
         iUeuWbsgB/sbE0kYBjB7TYG4JGZw2AxX37z5A2RWg6+kbfZfhxGzxTcAiauFunkDXtkv
         rfmg==
X-Gm-Message-State: AOAM531HbXl/CdquM4xzaKPYjMfcH0R2M5aHS4vxRB9ImPbDMVz3+q4a
        S5GVd4C6Fv90i9OzNahBJCCR7LwzCpFearWpDNCUUezMk8ELYDipJO0t7RH9c2xqEEtMCfTwXEv
        Wp48d3mOzmcKmHSfgJenMvE4=
X-Received: by 2002:adf:e6d0:0:b0:1f1:dfaa:ac39 with SMTP id y16-20020adfe6d0000000b001f1dfaaac39mr2753963wrm.239.1646904017552;
        Thu, 10 Mar 2022 01:20:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzMXR81qFgCUTGundH5fD8anpcBTCp5e7Z80vOv6gCXiwjYlZDWqw0qlo9jEpBHFQmTDNZpAg==
X-Received: by 2002:adf:e6d0:0:b0:1f1:dfaa:ac39 with SMTP id y16-20020adfe6d0000000b001f1dfaaac39mr2753944wrm.239.1646904017350;
        Thu, 10 Mar 2022 01:20:17 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id f4-20020a5d4dc4000000b001d8e67e5214sm3703107wru.48.2022.03.10.01.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 01:20:16 -0800 (PST)
Date:   Thu, 10 Mar 2022 09:20:15 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     mcgrof@kernel.org, christophe.leroy@csgroup.eu, hch@infradead.org,
        cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com
Subject: Re: [PATCH] kdb: Remove redundant module related references
Message-ID: <20220310092015.ekjquplcvqm3a2el@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220307174741.2889588-1-atomlin@redhat.com>
 <20220308105203.2981099-1-atomlin@redhat.com>
 <20220309120640.uumh46n2l37jaddf@maple.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220309120640.uumh46n2l37jaddf@maple.lan>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-03-09 12:06 +0000, Daniel Thompson wrote:
> On Tue, Mar 08, 2022 at 10:52:03AM +0000, Aaron Tomlin wrote:
> Another iteration makes more sense to me.

Hi Daniel,

Thanks for your feedback.

> The removal of the spurious #include's in other kdb files is a
> good change but it is fully independent of the module rework. AFAICT
> those fixes are good with or without your changes. This suggests
> these changes can be separate from the main patch set.

I will include these changes in the series too, as it cannot hurt.


Kind regards,

-- 
Aaron Tomlin

