Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEC0557273
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 07:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiFWFFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 01:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiFWFFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 01:05:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956D14D261;
        Wed, 22 Jun 2022 21:48:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6AC80B821BD;
        Thu, 23 Jun 2022 04:48:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34BECC341C5;
        Thu, 23 Jun 2022 04:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655959694;
        bh=xXYitukkcGiqtnEepPTDAygVPAaAiEswqKSEal/zsMo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z05KPjSIEcs0RLVlF4B/x1/VXXSyIsGizgtyQplamQDFPll2l/lws0rSWopKS85vZ
         AdRkpGRYyqolQKEkxhTe6YNGTFE/DiGTee3QhylTlw3joGiqzyUW+XkGcCvtepsfIG
         9PAHhc6iItKQlzaUywTN42d3Oc/osPu7iVT/XMBCy7aA4VMZiS+1qS3b95p0PC0sSb
         3YQh9PIuFvJEEHZI+9TIBISfsEaxf9dYI5hEep6SI8Zgieq2A68HHh2Z/iMsNJq4/b
         TXDU33kosgnY1lrgHVA3q4HFP437xlKeAz4Kvw/S4yFXH2hNFYF41+i6KYGv0WRcS7
         YpMcugKtS+Ajw==
Received: by mail-yb1-f176.google.com with SMTP id v81so33848112ybe.0;
        Wed, 22 Jun 2022 21:48:14 -0700 (PDT)
X-Gm-Message-State: AJIora/89rsIC2U7l90Aqj0ZOmpUXGRCdxdyMqWVT+6O/5l2bjDT40bj
        DYiGnPBvTQd03+4GFznCvC2HdmnhwgWQSJGa+Vw=
X-Google-Smtp-Source: AGRyM1vMdq/a9/L7qVuEmxyp1QTELRy1U7k2QXM3tioxi81TrWS32zEXG0z4hdzNGjJgIcIauLinQ3Uqzsq1HUpGFzA=
X-Received: by 2002:a05:6902:1543:b0:665:493b:e7f5 with SMTP id
 r3-20020a056902154300b00665493be7f5mr7678654ybu.322.1655959693265; Wed, 22
 Jun 2022 21:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220616191945.23935-1-logang@deltatee.com>
In-Reply-To: <20220616191945.23935-1-logang@deltatee.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 22 Jun 2022 21:48:02 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5uEPptD3U=a9vqiZE34mmx88Yc7npfWDdDDP0WZMORSA@mail.gmail.com>
Message-ID: <CAPhsuW5uEPptD3U=a9vqiZE34mmx88Yc7npfWDdDDP0WZMORSA@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] Improve Raid5 Lock Contention
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 12:20 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>
> Hi,
>
> Now that I've done some cleanup of the mdadm testing infrastructure
> as well as a lot of long run testing and bug fixes I'm much more
> confident in the correctness of this series. The previous posting is
> at [1].

Applied to md-next. Thanks for the great work!

Song
