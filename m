Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAEC34F0F29
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 08:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377403AbiDDGMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 02:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377394AbiDDGL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 02:11:58 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C5F1C91F
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 23:10:02 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id k25so10023543iok.8
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 23:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8NsrVtImWjpdc3DRwbLRWqAdracGEBMqr1JyxBipXZ0=;
        b=Kb9k+FhvpMEe/hS5w3NPbD1fP2PoutHoLKAoQWUV2sI61rCyJeyBNNU937Vtq9BrS1
         6KHSnHCu16vUR8mIwUDjqWNlWcT1UdLWSlmhkfLQRIwzuAfiBe5dD5/UCxMgwkW3bN8r
         /vxlAQiWEV1OamMjGDsG/Atj7EgzYBPgw4KqnuhqgUgCPuWP2+72TvhOkmhyE5mNlhl2
         Vr8k6k7MjLjwwpwVKn6Q13CKkTBG1O0nVoIcgNAgkIs0BenHbXyyisrPYPMaWdiU8Pg5
         0ft33vVxiqsKmIErrwnsWTVyKnjsNEhmLdslddBrRopemZKqzZloOHTGAWHS+NpmZjZw
         6OuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8NsrVtImWjpdc3DRwbLRWqAdracGEBMqr1JyxBipXZ0=;
        b=v4aXgHEicSr7aMmzKwZ5ZRU79wjwVbWRVwQfDNBhyd89GnMVFuExaGcR+6rxWi4MD4
         x1nl4Bj8P71jAYWAbzXoV2/t1V/ajsXgC1PPb3GWOxTAtaLZxEYDq7HFafBl4hqRDtcD
         QPaBuci/LvCOFtkLqF7YM4zHwkS5kp7UAxBlbMjVxhDiKDW7VtUq2XxyiO8S4ExCzbcq
         yTg3D8cbK0vtnYqoEEWUtvLii4M0JVy48/PPQbGybzYxQ+R9/eXLet4uSJJsaxm2YIVs
         YnHrV7m4SuKGGvGIXIqsIO3emHJplDYQS4BbFTvAc0qYzDmFQW3m+TZLG1geuvpeWZSf
         yEqw==
X-Gm-Message-State: AOAM5322ScpLUauPfq4OR0NV2ozdF1sXnivoc0Lig3QfCVB+cwSnlwsv
        E9gmIW7WOiLliiG0msnMN1c88Q==
X-Google-Smtp-Source: ABdhPJw+t1GS5uz9Bam4IoZJ75AdBpJNgGE1/0FoEc58mJE8ZXDInNTIx5EbtWNTO9p1HU3dYUv4AQ==
X-Received: by 2002:a05:6638:2653:b0:323:d901:9272 with SMTP id n19-20020a056638265300b00323d9019272mr3560184jat.208.1649052601665;
        Sun, 03 Apr 2022 23:10:01 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id u15-20020a056e021a4f00b002c665afb993sm5297152ilv.11.2022.04.03.23.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 23:10:01 -0700 (PDT)
Date:   Mon, 4 Apr 2022 06:09:57 +0000
From:   Oliver Upton <oupton@google.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     kvmarm@lists.cs.columbia.edu, maz@kernel.org,
        linux-kernel@vger.kernel.org, eauger@redhat.com,
        shan.gavin@gmail.com, Jonathan.Cameron@huawei.com,
        pbonzini@redhat.com, vkuznets@redhat.com, will@kernel.org,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Shannon Zhao <shannon.zhaosl@gmail.com>
Subject: Re: [PATCH v6 00/18] Support SDEI Virtualization
Message-ID: <YkqLtYquZQAKjbAk@google.com>
References: <20220403153911.12332-1-gshan@redhat.com>
 <a3bf5b44-0ab8-fd85-5557-6c496fd68bc1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3bf5b44-0ab8-fd85-5557-6c496fd68bc1@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gavin,

On Sun, Apr 03, 2022 at 11:47:07PM +0800, Gavin Shan wrote:
> I'm explicitly copying Oliver, James, Mark and Shannon to avoid resending this series.
> It seems they have been skipped even I explicitly copied them by 'git send-email --cc=<email-addr>'.

Dunno about others, but FWIW your first crack at sending this series out
arrived in my inbox just fine :)

Thanks for cc'ing me, I'll find some time this week to take a look.

--
Best,
Oliver
