Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319F34D50B1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242935AbiCJRhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238533AbiCJRh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:37:28 -0500
Received: from smtp-out3.electric.net (smtp-out3.electric.net [208.70.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C5F18DA81;
        Thu, 10 Mar 2022 09:36:27 -0800 (PST)
Received: from 1nSMi8-0007OR-VX by out3d.electric.net with emc1-ok (Exim 4.94.2)
        (envelope-from <kris@embeddedTS.com>)
        id 1nSMiA-0007RW-TQ; Thu, 10 Mar 2022 09:36:26 -0800
Received: by emcmailer; Thu, 10 Mar 2022 09:36:26 -0800
Received: from [66.210.251.27] (helo=mail.embeddedts.com)
        by out3d.electric.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <kris@embeddedTS.com>)
        id 1nSMi8-0007OR-VX; Thu, 10 Mar 2022 09:36:24 -0800
Received: from tsdebian (unknown [75.164.75.221])
        by mail.embeddedts.com (Postfix) with ESMTPSA id 09C892F5C;
        Thu, 10 Mar 2022 10:36:24 -0700 (MST)
Message-ID: <1646933773.2804.1.camel@embeddedTS.com>
Subject: Re: [PATCH v3 1/2] gpio: ts4900: Do not set DAT and OE together
From:   Kris Bahnsen <kris@embeddedTS.com>
Reply-To: kris@embeddedTS.com
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Featherston <mark@embeddedts.com>
Date:   Thu, 10 Mar 2022 09:36:13 -0800
In-Reply-To: <CAHp75Vdu1r0S2ZCjH2mjToYZiwQTOiUAvY5v-T7f=u28tVuxcQ@mail.gmail.com>
References: <20220310011617.29660-1-kris@embeddedTS.com>
         <20220310011617.29660-2-kris@embeddedTS.com>
         <CAHp75Vdu1r0S2ZCjH2mjToYZiwQTOiUAvY5v-T7f=u28tVuxcQ@mail.gmail.com>
Organization: embeddedTS
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Outbound-IP: 66.210.251.27
X-Env-From: kris@embeddedTS.com
X-Proto: esmtps
X-Revdns: wsip-66-210-251-27.ph.ph.cox.net
X-HELO: mail.embeddedts.com
X-TLS:  TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256
X-Authenticated_ID: 
X-Virus-Status: Scanned by VirusSMART (c)
X-Virus-Status: Scanned by VirusSMART (b)
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=embeddedTS.com; s=mailanyone20220121;h=Mime-Version:References:In-Reply-To:Date:To:From:Message-ID; bh=1FAV9s0Divigxh+nUf89EO0OPgHVoo4GOAY0f7g9/+g=;b=cVMEJL4SBd2BYmBxpAnrk9srTZpa/0kDx6fP41R57+aiw+gtegXkiGKis1bK8DCMv32dJmxlv8SBLSaAIF0Euz3e132sfe3IBWh1B6a8pfwMwKWt8xugsz8LZh1eUvUliSbd50yaupMAB5BsG5ztkkqQz8fYspb2aWm7u75Myb/JnDtr9SEQ7R7hdXFCNn8uw1zxHvpMyA1pO0jqZNexTgpSWlEdOAhWIdFJrcAAB93deL0Yi9HHAfifxptqdDKNyDjZc3WARlXNuffRL2rwE/9xj8OveI+HDRxy7Wtii6BqvOqVr+pk7zWg/I4KUmiSP/3HawELuB8nOvbuESsbzw==;
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-03-10 at 16:48 +0200, Andy Shevchenko wrote:
> On Thu, Mar 10, 2022 at 2:22 PM Kris Bahnsen <kris@embeddedts.com> wrote:
> > 
> > From: Mark Featherston <mark@embeddedTS.com>
> 
> Same comments as per v2.
> 

Thanks, I'll get a v4 put together shortly to clean that up.
