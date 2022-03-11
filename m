Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B844D65B2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 17:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350138AbiCKQEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 11:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350247AbiCKQDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 11:03:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 066C21CD9C9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 08:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647014517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rzupkkLJorsxLrR+OX5BVyDV3vQCDlEKQHwxOJHubCQ=;
        b=dIpFZphqOUrcy3vRpe0kU2J3kBTuw+stciQYZ60nKAITFMUhPwqNwKhXUmYdpN50aLMvmV
        oFr40t2BjXxwDI7kH52RYt5amu0poR/qJAoSMuASn50MFCmNAYSiCTMPyusDHNG2498c2u
        ne+++OyXLRnSK6wpyLREjk3Ji2Tk/2s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-PMU8aHU_PL6qxLYmNbkhSQ-1; Fri, 11 Mar 2022 11:01:56 -0500
X-MC-Unique: PMU8aHU_PL6qxLYmNbkhSQ-1
Received: by mail-wr1-f70.google.com with SMTP id a16-20020adff7d0000000b001f0473a6b25so2964052wrq.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 08:01:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rzupkkLJorsxLrR+OX5BVyDV3vQCDlEKQHwxOJHubCQ=;
        b=g39M3L29Ue0a86c0zqAn2w4iCTeOToud2y4b+fr2ctpT1xT37KdefbMwL/Un6l0Fvk
         D1QdAWVKvyINDXFWDK81LJr2b8yC+Jvo5FeG7lI6WLOdwrq+rMJlfLGfjOCfuNOMZntC
         4u5gfbIcOgFiU0SYlbSC3mPefHWiM00pi+A8AF7MsQyq/1MN13E6NUqEGg5wO7ylVGO3
         y8mhnjviHj2ZnYfDZ5RwkBkF6d+iTRqLcdsGdtxHp3bDWBdIGN6LEOKBp+XAWmOiP30x
         S5UE5l8wjTnpxEDn0S7g5C3Vm+WiPfQv6+4J3sJZVmtJOiuBZporOGiuDYhZinj5CDzd
         anqw==
X-Gm-Message-State: AOAM533o5k2RznXQAGOA94GurawsG3S/7w86v5VYOQD36EYYycYKHJMg
        Pdlf6ensfclNqX3niP5IQC2wDdvvhTLNNi1bO+brsWf3pbza2zoRC3nI5uVeNxEwDCuJOWeDoN+
        vpjBjBlmMGyn0NxG/0CcX61I=
X-Received: by 2002:a5d:684b:0:b0:1f1:fc5d:d91c with SMTP id o11-20020a5d684b000000b001f1fc5dd91cmr7821707wrw.266.1647014514877;
        Fri, 11 Mar 2022 08:01:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzuysRnBXAFiroTtcVLgk2nMYmL7tDhq1rUhjyinUARX5WWN8WwymIFesIXi0FesbUeSQhPGg==
X-Received: by 2002:a5d:684b:0:b0:1f1:fc5d:d91c with SMTP id o11-20020a5d684b000000b001f1fc5dd91cmr7821672wrw.266.1647014514642;
        Fri, 11 Mar 2022 08:01:54 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id x2-20020adff0c2000000b001f1fa284a32sm6996838wro.115.2022.03.11.08.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 08:01:53 -0800 (PST)
Date:   Fri, 11 Mar 2022 16:01:53 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, christophe.leroy@csgroup.eu,
        hch@infradead.org, cl@linux.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        void@manifault.com, atomlin@atomlin.com, allen.lkml@gmail.com,
        joe@perches.com, msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com
Subject: Re: [PATCH] kdb: Remove redundant module related references
Message-ID: <20220311160153.3k2avq24mpjyrdpy@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220307174741.2889588-1-atomlin@redhat.com>
 <20220308105203.2981099-1-atomlin@redhat.com>
 <20220309120640.uumh46n2l37jaddf@maple.lan>
 <YiporeSIrkFg/YS8@bombadil.infradead.org>
 <20220311154723.ezo3wvgg4puu2zk7@maple.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220311154723.ezo3wvgg4puu2zk7@maple.lan>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-03-11 15:47 +0000, Daniel Thompson wrote:
> On the whole it doesn't really matter much... but landing the
> independent parts via the normal route for kgdb code reduces what I
> have to remember acking.

Hi Daniel,

Any thoughts on this [1]? Unfortunately, the wrong In-Reply-To was
specified. So sorry about that. I will send another iteration of the series
so that it'll be easier for Luis to apply to mcgrof/modules-testing or
mcgrof/modules-next but after we have more feedback.

[1]: https://lore.kernel.org/lkml/20220310102625.3441888-2-atomlin@redhat.com/


Kind regards,

-- 
Aaron Tomlin

