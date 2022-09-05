Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA0E5AD8B0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 20:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbiIESAq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 5 Sep 2022 14:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbiIESAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 14:00:41 -0400
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB7130F7E;
        Mon,  5 Sep 2022 11:00:40 -0700 (PDT)
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay01.hostedemail.com (Postfix) with ESMTP id 0701E1C7378;
        Mon,  5 Sep 2022 18:00:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id 0D4F120027;
        Mon,  5 Sep 2022 18:00:36 +0000 (UTC)
Message-ID: <f550b468064c61e3550b50da37138802d7e9415a.camel@perches.com>
Subject: Re: [PATCH] checkpatch: warn for non-standard fixes tag style
From:   Joe Perches <joe@perches.com>
To:     Niklas =?ISO-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@corigine.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, oss-drivers@corigine.com,
        Simon Horman <simon.horman@corigine.com>,
        Louis Peens <louis.peens@corigine.com>
Date:   Mon, 05 Sep 2022 11:00:35 -0700
In-Reply-To: <YxXUHPWtyrt6kNI1@sleipner.dyn.berto.se>
References: <20220829155358.2546732-1-niklas.soderlund@corigine.com>
         <dc45a7021bb765ea34c5b9228454f255764c7bc9.camel@perches.com>
         <YxXUHPWtyrt6kNI1@sleipner.dyn.berto.se>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Stat-Signature: uncp4j6xx9jbwat6rjj9xty5a5f8dd17
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 0D4F120027
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+n5QMvrlHvXTuREULemMyhNEhC5t3e5V0=
X-HE-Tag: 1662400836-313636
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-09-05 at 12:49 +0200, Niklas Söderlund wrote:
> Hi Joe,
> 
> Thanks for your feedback.
> 
> On 2022-08-29 23:06:43 -0400, Joe Perches wrote:
> > > +			if ($line =~ 
> > > /(fixes:)\s+([0-9a-f]{5,})\s+($balanced_parens)/i) {
> > 
> > Maybe use fixes:? so the colon is not required in poorly formed uses
> 
> I tried that but I think it brings more problems then it is worth. With 
> that change the check would run for each line of the commit message that 
> begins with the string 'fixes', not just in the tags section of the 
> message. So it would warn for the commit message,

I think it's not a problem.
Look at the results of:

$ git log -100000 --no-merges --format=email --grep="^fixes" -i | \
  grep -i -P -oh '^fixes:?\s*[0-9a-f]{5,}\s*..' | \
  sed -r -e 's/^(fixes:?\s*)[0-9a-f]+/\1/i' | \
  sort | uniq -c | sort -rn | head -20
  73974 Fixes:  ("
   1345 Fixes:  ('
    399 Fixes: 
    246 Fixes:  (A
    215 Fixes: ("
    172 Fixes:  (c
    121 Fixes:  (s
    114 Fixes:  (d
    110 Fixes:  (P
     98 Fixes:  (i
     90 Fixes:  (m
     86 Fixes:  (n
     78 Fixes: : 
     57 Fixes  ("
     51 Fixes:  "n
     47 Fixes:  (a
     46 Fixes:  (t
     43 fixes:  ("
     42 Fixes:  (p
     41 Fixes: ('


