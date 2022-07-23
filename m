Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7449B57EF11
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 13:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234428AbiGWLlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 07:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiGWLlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 07:41:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBF0E0AE;
        Sat, 23 Jul 2022 04:40:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2E70B80906;
        Sat, 23 Jul 2022 11:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861D4C341C0;
        Sat, 23 Jul 2022 11:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658576456;
        bh=WIe7y2pDQXUhDeALdGhb6ETAfomqWoK+C8ML8M8aVoo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=VdQ+FC6yid26Gl9nR8I8J2XCtC33TtALCQn8iOhhIt+tWHZQo04szuLwJnUcMC0BK
         DfJ/K1FubRiuOtYAP/NZT7LnssE/fqZcLoVY9SpIflX4N7KD6pL83svaavsk9taacE
         g98dUVwsy/3phWLNTSBOjOgnjTqzX/oYSNaG2rbeW+pIyko/nQ3jh1Xm4+9suv/DwW
         IoSROhatn48/e53MztcN+4By/vOBo+z2bOiu5/LXwTEEHCrV/lkAEfd4JmpR++VfAw
         Jvlkyrb5QphyhkKHORBCt9fzwstnab8NL88FaypmVxBxHqwkLFVOL/bP3EwrYfki+/
         T5g1pT/d9aYvA==
Date:   Sat, 23 Jul 2022 13:40:53 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Stefan Hansson <newbie13xd@gmail.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?ISO-8859-15?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Subject: Re: PROBLEM: Regression likely in hid_uclogic driver breaks Huion
 Inspiroy H640 drawing tablet
In-Reply-To: <9e16d503-2203-57ed-d6af-61fea0c3e10b@gmail.com>
Message-ID: <nycvar.YFH.7.76.2207231339500.19850@cbobk.fhfr.pm>
References: <9e16d503-2203-57ed-d6af-61fea0c3e10b@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jul 2022, Stefan Hansson wrote:

> Hi!
> 
> Somewhere between Linux 5.17.6 and 5.18.11 the Huion tablet I have stopped
> working properly. In GNOME Control Center it is identified as Huion New 1060
> Plus, however that's a different tablet than the one I have. Mine is a Huion
> Inspiroy H640, and it uses the hid_uclogic driver.
> 
> With Linux 5.17.6, the tablet works as expected with all the buttons being
> detected and the stylus being usable. With 5.18.11, the buttons work fine but
> the stylus does not work correctly. The first time I approach the tablet with
> the stylus it works properly, i.e., the cursor on my screen moves around and
> follows the stylus around the tablet as expected. It continues working like
> this until I remove the stylus from the tablet. After I remove it from the
> tablet, the cursor never gets controlled by the stylus again. I can see that
> the tablet detects the stylus (it has a small indicator light), but the cursor
> doesn't move when I approach the tablet again. To clarify, with Linux 5.17.6,
> the cursor moves around just fine when I remove and then put it back to the
> tablet, just as you would expected.
> 
> It may also be worth noting that it worked fine when I previously used it
> around six months ago, although I'm not sure what version of Linux I was using
> at that time (whatever Fedora shipped back then). I also tried reproducing it
> with yesterday's linux-next and Linux 5.19.0-RC7, and the behaviour was the
> same as 5.18.11. I am currently trying to bisect this, but it's not going very
> fast as I currently only have access to a dual core laptop from 2014, so
> building Linux takes a good while.

Thanks for the report. CCing José who has been doing a lot of work in this 
area recently, maybe he has an immediate idea.

If not, perhaps bisecting the hid-uclogic.c commits between the two 
kernels would be the quickest option.

-- 
Jiri Kosina
SUSE Labs

