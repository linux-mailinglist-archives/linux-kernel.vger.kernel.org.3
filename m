Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEA158864E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 06:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbiHCEXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 00:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbiHCEXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 00:23:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCAD56B89
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 21:23:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51B1EB82185
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 04:23:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5ADBC433C1;
        Wed,  3 Aug 2022 04:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659500590;
        bh=57FYgrDA5JTLKEQSQAnXzMDnK8vQIpejERMWzMtvXwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UUU/An0TCvdPWFwdAQAwh0U3zulXQTYzGW/6gFuOr+TkqvZwYn/facOQN3ef+9QKx
         r9lg9R0ZrZOVwdlVnWeRrD4pj5glg34O7ZjrqvPwDvbNioFqtZXLvJzWk6gQYHRyeH
         HM3sgIznkuTPHQJCpszkO0Q0/c21RJohQq3K5W7xrN1hVEEgQQT+39lNPDE0tGA6G8
         oyYzSLjApnancZ4ZZPp0ApcOQkiTHHwo/7op0FT957ctE/GiutL1Ng3ehfqAgXirP4
         +aSAVjkqonIkZlTcAUgtGL0bG6Pyw6qbsHBk8NY+GmYcqN3fQGHcj6E/MHfa/u2jVG
         2Ef+IUBfZyETg==
Date:   Tue, 2 Aug 2022 21:23:08 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     Zdenek Kabelac <zdenek.kabelac@gmail.com>,
        Brian Geffon <bgeffon@google.com>,
        Mike Snitzer <snitzer@kernel.org>,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Mikulas Patocka <mpatocka@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [dm-devel] [PATCH 1/1] dm: add message command to disallow
 device open
Message-ID: <Yun4LH+StcuBXRtO@sol.localdomain>
References: <20220704000225.345536-1-dlunev@chromium.org>
 <20220704100221.1.I15b3f7a84ba5a97fde9276648e391b54957103ff@changeid>
 <YtB45Lte5UhlEE6y@redhat.com>
 <CAONX=-dEG121RQ6L-4fPMXrLXb3JeYNVNiPzHXNaRLbwRzb3bw@mail.gmail.com>
 <alpine.LRH.2.02.2207150528170.5197@file01.intranet.prod.int.rdu2.redhat.com>
 <cca5b463-a860-de8d-b7e4-a8d30aef2ff2@gmail.com>
 <CAONX=-fJHgfGkwR5A1MT+8FHckueehOsUS_LyHkjrgp4Y+vOgw@mail.gmail.com>
 <CAONX=-ft=ewFDui4jmd2fvcNr2EJc90=ZNOueDdp6HaPZmvObQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAONX=-ft=ewFDui4jmd2fvcNr2EJc90=ZNOueDdp6HaPZmvObQ@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 02:12:26PM +1000, Daniil Lunev wrote:
> Hello all
> To signal boost here. What can we do to advance the discussion on this
> topic? Can we move forward with the approach or are there any
> alternative suggestions how the desired behaviour can be achieved?
> Thanks,
> --Daniil
> 
> On Tue, Jul 19, 2022 at 9:42 AM Daniil Lunev <dlunev@chromium.org> wrote:
> >
> > We understand that if someone acquires root it is a game over. The intent of
> > this mechanism is to reduce the attack surface. The exposure might be a
> > certain system daemon that is exploited into accessing a wrong node in
> > the filesystem. And exposing modifiable system memory is a pathway for
> > further escalation and leaks of secrets. This is a defense in depth mechanism,
> > that is intended to make attackers' lives harder even if they find an
> > exploitable
> > vulnerability.
> > We understand that in regular situations people may not want the behaviour,
> > that is why the mechanism is controlled via a side channel - if a message is
> > never sent - the behaviour is not altered.
> > --Daniil

This seems like an access control policy, which the Linux kernel already has a
lot of mechanisms for.  Chrome OS already uses SELinux.  Couldn't this be solved
by giving the device node an SELinux label that no one has permission to open?

- Eric
