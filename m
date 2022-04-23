Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5437250CD64
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 22:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237026AbiDWU3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 16:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236826AbiDWU3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 16:29:12 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FE230F7B
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 13:26:14 -0700 (PDT)
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 8CA43761447;
        Sat, 23 Apr 2022 20:26:13 +0000 (UTC)
Received: from pdx1-sub0-mail-a217.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 06AEE7610DA;
        Sat, 23 Apr 2022 20:26:13 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1650745573; a=rsa-sha256;
        cv=none;
        b=HrsnwRPAKoYCdb++CQmV06NqQCNHK//Rpb52c+s/i8FnYQSSIcPFTNwmsaK+U2x5W8fxEL
        V20gARZiCoo8QxAIf81RvgAUw4NZFtqB4i9TKckncK3Jea1GcOqs7x5g4qgo2rJLHpQt15
        J5Q2NJRpX4bk2kPK2w6N+evr5VZK/WNYa9JLf8Hloir1E7N3BBEo85ofuiOZrSv+IUN1l+
        KiCOrBrYJ7YaFils1qcrQ4BNm0mXE8lhY1ZLiEg3/nksvpWwa1Evy+hd5/yP9jpi5APOkW
        UzgFdqRF2i6qnSwwnUHWy2/COibtkRVkhDPsfC6sKO15OoOpptz0FgaYBuLc4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1650745573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=If3a+XAfKC9ETHINvDeSFjAtwlkrAIRmiOjHKDaqexM=;
        b=gF1GXNatobo1KnZ6NS3sX4N1pQS7GuWtoZVyVp0fxxHhnmPe2WI4NCUaFG3KbpirNxS/LL
        bNhWkQGhljVA7KoP3KTDWLIVolEMPyYOalXgzFn77yDRitFnmezpf+z333IeVEPis6kiOw
        suGL+1OJn3lyIRB1ETSt9olZSTyBdKmXx77EbBVIQE/9nZdIrWgfXcsicX45SJOFQXmUcQ
        yNFi7OXY3hMGpDe63XR0Z4YrGP4b1lrmdLP+h+e3VLVaUCNZ2audOsIIN4WapNhY7StLAE
        26qSmLqt/gb+DNMxEj2VHaYI7py9DapJ5hJq2D9gfbGukJZcn9/hxuWqsqTmfQ==
ARC-Authentication-Results: i=1;
        rspamd-6dfbdcb948-956sg;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=ian@linux.cowan.aero
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|ian@linux.cowan.aero
X-MailChannels-Auth-Id: dreamhost
X-Versed-Celery: 5b5b46a97e752c1a_1650745573266_757368808
X-MC-Loop-Signature: 1650745573266:3015499548
X-MC-Ingress-Time: 1650745573266
Received: from pdx1-sub0-mail-a217.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.106.158.165 (trex/6.7.1);
        Sat, 23 Apr 2022 20:26:13 +0000
Received: from fedora (unknown [69.12.38.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ian@linux.cowan.aero)
        by pdx1-sub0-mail-a217.dreamhost.com (Postfix) with ESMTPSA id 4Km2q83pC9z2g;
        Sat, 23 Apr 2022 13:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.cowan.aero;
        s=dreamhost; t=1650745572;
        bh=If3a+XAfKC9ETHINvDeSFjAtwlkrAIRmiOjHKDaqexM=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=fpNxUw04detkYUvrWZqhFxFn+gEx83WalSkfwcBMbYUejWgkeZdHFfq/HQkBXaLG8
         NTGiIKAyGsmeOAItSF5NVrLNLho3VjRCBgfn9/msIkTCr4JNOydnNBld17en/fGDZx
         OUG7mvlMpggrbbHJkXRraHYZXKEoSxzkO+wpnm1B7lS/CkU7PMg5FsSuHNsPUtYqH/
         SGeeaITz58IhpVZHQZwRNK0EniPEzpb+ySZzdI6wysXJvPZFXkR3Pyx0aqOs4aAZLl
         hYz1JcavPMgXNCDZTx8pErBjdmq62yGdASQ883akESoL/9joh97Q4BuEWdeQcr1X+Z
         pQIxhqeGelQPg==
Date:   Sat, 23 Apr 2022 16:26:10 -0400
From:   Ian Cowan <ian@linux.cowan.aero>
To:     Ozgur Karatas <ozgurk@ieee.org>
Cc:     linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: Re: [PATCH] scripts: get_maintainer: add an option to format for
 command line
Message-ID: <YmRg4m2yOCeiOv8E@fedora>
References: <20220423185552.126453-1-ian@linux.cowan.aero>
 <CAADfD8yJGBJz03+j16Z2EmEwkB_vXf6920NY0LLTFMNvq092uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADfD8yJGBJz03+j16Z2EmEwkB_vXf6920NY0LLTFMNvq092uw@mail.gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 11:20:54PM +0400, Ozgur Karatas wrote:
> On Sat, Apr 23, 2022 at 10:56 PM Ian Cowan <ian@linux.cowan.aero> wrote:
> 
> > This adds the option to return the list of maintainers in the format for
> > sending via command line, specifically targeted for `git send-email`.
> > This will add a `--to` tag before the first email and a `--cc` tag for
> > each following email. The option can be toggled by using the
> > `--cl-format` flag when calling the get_maintainer script.
> >
> > The new addition is disabled by default and will only print (even if
> > enabled) if there are maintainers to return. This will prevent the
> > script from trying to generate a formatted line without any maintainers
> > and also allow the user to visually verify that the outputted line contains
> > the correct maintainers and lists (by verifying the roles).
> >
> >
> Hello,
> 
> actually i have been using easier wrapper commands for a long time now, so
> what say Joe is right.
> get_maintainer.pl script will get all emails and just add them git
> send-email --to or --cc
> 
> Regards
> 

Sounds good, I will go about it this way!

Ian

> 
> 
> > Signed-off-by: Ian Cowan <ian@linux.cowan.aero>
> > ---
> >  scripts/get_maintainer.pl | 29 +++++++++++++++++++++++++++--
> >  1 file changed, 27 insertions(+), 2 deletions(-)
> >
> > diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> > index 6bd5221d37b8..fc6844a56c87 100755
> > --- a/scripts/get_maintainer.pl
> > +++ b/scripts/get_maintainer.pl
> > @@ -53,6 +53,7 @@ my $output_section_maxlen = 50;
> >  my $scm = 0;
> >  my $tree = 1;
> >  my $web = 0;
> > +my $format_for_cl = 0;
> >  my $subsystem = 0;
> >  my $status = 0;
> >  my $letters = "";
> > @@ -269,6 +270,7 @@ if (!GetOptions(
> >                 'scm!' => \$scm,
> >                 'tree!' => \$tree,
> >                 'web!' => \$web,
> > +               'cl-format!' => \$format_for_cl,
> >                 'letters=s' => \$letters,
> >                 'pattern-depth=i' => \$pattern_depth,
> >                 'k|keywords!' => \$keywords,
> > @@ -636,8 +638,13 @@ my %deduplicate_address_hash = ();
> >
> >  my @maintainers = get_maintainers();
> >  if (@maintainers) {
> > -    @maintainers = merge_email(@maintainers);
> > -    output(@maintainers);
> > +       my @maintainers_merged = merge_email(@maintainers);
> > +       output(@maintainers_merged);
> > +
> > +       if ($format_for_cl) {
> > +               my @format_for_cl = format_cl(@maintainers);
> > +               output(@format_for_cl);
> > +       }
> >  }
> >
> >  if ($scm) {
> > @@ -1071,6 +1078,7 @@ Output type options:
> >    --separator [, ] => separator for multiple entries on 1 line
> >      using --separator also sets --nomultiline if --separator is not [, ]
> >    --multiline => print 1 entry per line
> > +  --cl-format => Include a formatted string for emailing via the command
> > line
> >
> >  Other options:
> >    --pattern-depth => Number of pattern directory traversals (default: 0
> > (all))
> > @@ -2512,6 +2520,23 @@ sub merge_email {
> >      return @lines;
> >  }
> >
> > +sub format_cl {
> > +       my @out;
> > +       my $first = 1;
> > +
> > +       for (@_) {
> > +               my ($address, $role) = @$_;
> > +               if ($first) {
> > +                       $first = 0;
> > +                       @out = "--to '$address'";
> > +               } else {
> > +                       @out = "@out --cc '$address'";
> > +               }
> > +       }
> > +
> > +       return ('', @out);
> > +}
> > +
> >  sub output {
> >      my (@parms) = @_;
> >
> > --
> > 2.35.1
> >
> >
