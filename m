Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C8E5403F3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 18:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345126AbiFGQk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 12:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245131AbiFGQky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 12:40:54 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA40C9644
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 09:40:53 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id u2so16004350pfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 09:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W8rwN3Jx6kG6W0OrIJ1jYETqFXWQxvnr8RKgWWTrkqM=;
        b=XMHL4/Jkz5kuNpGJNXQ/Bo9VoJybfxuND8WBmMI71IqhCvC7buvP65oeqaka6UadH9
         5UqxLIR28QxB/gb5tpJ2llJeXyrNvOeT44QmE31thANjqX/QoVR5cnjd3xsId4TERasE
         iPXSvqb8WxlFGHgLqVvERupW83X2FEpTTGyuH2ZxPA7MO1uTRmmn1Bqj36ufVYuoRPn5
         ZLvNIwuEBcm9X+rOovVNraALF/yN03+I7A/VkjMnHvD1Aj2t4Kg//FZGzQZKB2Nss2Oc
         bV74X/eDXR2ZbuvmkpfHaZC90iU2l6teCb1Js+KcbJQOAjeyHu0xq6HUZXFXmQoktJcU
         lBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W8rwN3Jx6kG6W0OrIJ1jYETqFXWQxvnr8RKgWWTrkqM=;
        b=Gz9WxLLNekrz5fYATAdgamZyDmsqygpkmECAPpwgl6+9qICPNzTyivT8HrRszQ/Zf0
         XRBjIQLAhU/gien0h3+t1uwLJN65BmQ8aybp7ilNoDR292ZZjSr6imUB7Dv8LqrkTauD
         Xk4ToGFQyHaElK3xIlRxJs4i7p2ZAL01yglWb0PgLQl7xZ7q6xmAAfC97kXQAommJFp6
         ftXs9jjgQTrIvROMk00/z9hw/3lX8o1EmMs25vSjTWH7+6xwXNhB2RL6GzZr0S4aoHvc
         XWJtGopCNYxJNAoioBeqBqgBh9epldIoTok3LuVRXMtvvclkUu8ZTTrgttdXJr1MNB0Y
         iLGQ==
X-Gm-Message-State: AOAM533YVqNmf0fSHgCsBz/u/WnttBRCvc/LUa43G/ovscqVZ99Dx5zN
        INgqbZSCQNTLTk1xoeOy26A=
X-Google-Smtp-Source: ABdhPJyccfA+r17Q/AS9I4VBKNAtHMpjPjAethjyWPjji/o+/dd2tRPjIEWVlBmmMSWdhKxzby/1cQ==
X-Received: by 2002:a63:84c3:0:b0:3fc:87ff:cdfa with SMTP id k186-20020a6384c3000000b003fc87ffcdfamr25671860pgd.460.1654620052837;
        Tue, 07 Jun 2022 09:40:52 -0700 (PDT)
Received: from fedora ([2601:1c1:4202:28a0::ec2b])
        by smtp.gmail.com with ESMTPSA id y9-20020a1709027c8900b0016782c55790sm3877042pll.232.2022.06.07.09.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 09:40:52 -0700 (PDT)
Date:   Tue, 7 Jun 2022 09:40:50 -0700
From:   Jared Kangas <kangas.jd@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     vaibhav.sr@gmail.com, mgreer@animalcreek.com, elder@kernel.org,
        gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
        johan@kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: greybus: audio: fix loop cursor use after
 iteration
Message-ID: <Yp9/kqBUzpArfPdn@fedora>
References: <20220605231806.720085-1-kangas.jd@gmail.com>
 <20220606130626.GX2146@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606130626.GX2146@kadam>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for catching that! Is there anything I need to do to add the
'Fixes:' tag to the patch? From my understanding, adding tags is done by
a maintainer later on, but I'm new to the patch submission process so I
want to make sure I'm not missing anything.

Jared
