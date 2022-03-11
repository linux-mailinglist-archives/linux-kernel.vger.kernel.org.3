Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7105B4D6094
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 12:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348239AbiCKLbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 06:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbiCKLbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 06:31:12 -0500
X-Greylist: delayed 1338 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Mar 2022 03:30:08 PST
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8942619E0B8;
        Fri, 11 Mar 2022 03:30:08 -0800 (PST)
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 22BB6prM000315;
        Fri, 11 Mar 2022 05:06:51 -0600
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 22BB6oR9000314;
        Fri, 11 Mar 2022 05:06:50 -0600
Date:   Fri, 11 Mar 2022 05:06:50 -0600
From:   "Dr. Greg" <greg@enjellic.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, corbet@lwn.net
Subject: Re: [PATCH V2 06/32] x86/sgx: Support VMA permissions more relaxed than enclave permissions
Message-ID: <20220311110650.GA32701@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <cover.1644274683.git.reinette.chatre@intel.com> <0555a4b4a5e8879eb8f879ab3d9908302000f11c.1644274683.git.reinette.chatre@intel.com> <YiY8bD/QcmcHH8dz@iki.fi> <774e906c-53fc-279c-1fb7-0922557a9da5@intel.com> <YicQbzR1o1qZUGbw@iki.fi> <YiccplUukAJ5SeFn@iki.fi> <YiceFtul/VsViuUu@iki.fi> <e7e8dde9-b929-4a01-1e39-dbf3303fdd0c@intel.com> <YieLk2YIMD9i8djv@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YieLk2YIMD9i8djv@iki.fi>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Fri, 11 Mar 2022 05:06:52 -0600 (CST)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 07:00:03PM +0200, Jarkko Sakkinen wrote:

Good morning, I hope this note finds the week ending well for
everyone.

Based on previous experiences, I wasn't going to respond to this
conversation.  However, after seeing Thomas' response to Cathy's
microcode patch series, and reflecting on things a bit, I thought it
would be useful to do so in order to stimulate further scholarly discussion.

For the record, Thomas was spot-on with concerns about how much sense
it makes to persist enclaves through a microcode update.  Everyone
despises downtime, but if you are serious about security, idling a machine
out to fully 'reset it', in the face of a microcode update seems to be
the only prudent action.

However, with all due respect, the assertion that Linux is all about
the highest standards in technical honesty and soundness of
engineering, are specious, at least in the context of the development
of this driver.

I see that Jarkko noted his conversations with Mark Shanahan on SGX
micro-architectural details.  For the record, I have been fortunate
enough to have engaged with Shanahan, Razos, Johnson and a number of
the other engineers behind this technology.  I've also had the
opportunity to engage with and provide recommendations to the SGX
engineering team in Israel, before the demise of the Platform Security
Group and the exile of SGX to servers only.

I believe that Simon Johnson received a Principal Engineer nomination
for his work on SGX.  He called me one morning here at the lake and we
had a rather lengthy and entertaining discussion about the issues
surrounding doing packet inspection from inside of an enclave, I
believe at 40 GBPS line rates, maybe 10, I can't remember.  In any
event, way faster then what could be accomplished in the face of the
~60,000 cycle overhead of untrusted<->trusted context switches, which
in turn motivated the 'switchless' architecture.

So with the length and girth discussions at bay, reflections on the
technical and security issues at hand follow below, for whatever they
are worth.

> On Tue, Mar 08, 2022 at 08:04:33AM -0800, Reinette Chatre wrote:
> > ok, with the implications understood and accepted I will proceed
> > with a new series that separates EPCM from PTEs and make RWX PTEs
> > possible by default for EAUG pages. This has broader impact than
> > just removing the three patches you list. "[PATCH 07/32] x86/sgx:
> > Add pfn_mkwrite() handler for present PTEs" is also no longer
> > needed and there is no longer a need to flush PTEs after
> > restricting permissions. New changes also need to be considered -
> > at least the current documentation. I'll rework the series.

> Yes, I really think it is a solid plan. Any possible LSM hooks would
> most likely attach to build product, not the dynamic behaviour.

I assume everyone remembers, if not the kernel archives will have full
details, that we had a very lively discussion about these issues
starting well over two years ago.

Jarkko's, rather dogmatic assertion, that it should simply be 'The
Wild West', with respect to PTE memory permissions on dynamically
allocated enclave memory, suggests that all of the hand wringing and
proselytizing about SGX being a way to circumvent LSM controls on
executable memory were political and technical grandstanding,
amounting to nothing but security theater.

Apologies if this is perceived to be a bit strident, it had been a
long week already on Wednesday morning.

I made the point at the time, that remained unacknowledged, that none
of the machinations involved had any practical security value with
respect to where everyone wanted this technology to go, ie. a driver
with full Enclave Dynamic Memory Management (EDMM) support, which is
the precipice on which we now stand.

I noted that the only valid security controls for this technology were
reputational controls based on cryptographic identities.  In fact, we
developed, and posted, a rather complete implementation of such an
infrastructure.  Here is a URL to the last patch that we had time to
fuss with putting up:

ftp://ftp.enjellic.com/pub/sgx/kernel/SFLC-5.12.patch

I think we have a 5.13, if not a 5.14 patch laying around as well.

The response, from one of the illuminaries in these discussions was;
"I dare you to post the patches so I can immediately NACK them".

I guess that pretty much covers the question of why their may be
perceived reluctance in some quarters about spending time trying to
upstream kernel functionality.

So, it was with some interest, that I noted Reinette Chatre's recent
e-mail which indicated, that in the face of the EDMM driver and the
security implications it presents, a proof-of-concept implementation
for reputational security controls had been developed.  That
implementation is based on MRENCLAVE and/or MRSIGNER values, both
cryptographically based identities, as was ours.

Although we didn't bother with MRENCLAVE values, for largely the same
reason why SGX_KEYPOLICY_MRENCLAVE isn't considered useful for
symmetric key generation inside of an enclave, with perhaps the
exception of shrouding keys to defeat speculation attacks.

So, to assist the conversation, and for the 'Lore' record.

In an EDMM environment, anyone with adverse intent is going to simply
ship an enclave that amounts to nothing more than a bootloader.  Said
enclave will setup a network connection to an external code
repository, which will verify that it is only talking to a known
enclave through remote attestation, and then download whatever code,
via a cryptographically secured connection, that they actually want to
run in the enclave.

How do I know that?

I know that because we were paid to develop those types of systems by
customers who wanted to run proprietary and/or confidential code in
the 'cloud'.  It was interesting to see the number of groups that
looked at SGX as a means to protect their 'secret sauce'.

I conclude, from Jarkko's comment above, that the kernel is going to
simply ignore this threat scenario, seems vaguely unwise.

So, perhaps the best way to advance a profitable discussion, is for
the involved kernel developers to state, for the benefit of those of
us less enlightened, how effective LSM's are going to be developed for
the EDMM threat model.

I can offer up a few strawmen approaches

- Refuse any socket connections to an application that maps an enclave.

- Refuse to allow an application mapping an enclave to access any
files, particularly if it looks like they contain encrypted content.

- Count the number of page mappings requested and decide that NN pages
are OK but NN+ are not, MAP_POPULATE returns E2BIG??

- Implement seccomp like controls to analyze and interpret OCALL
behavior.

The first three seem a bit like show-stoppers when it comes to doing
anything useful with SGX, seccomp has a reputation of being hard to
get 'right', that would seem to be particularly the case here.

Perhaps something more exotic.

How about a BPF enabled LSM that monitors enclave page access
patterns, so a concerned system administrator can build custom
variants of the directed page side channel attack that Oakland
demonstrated against Haven.  Oakland, in his conclusions, described
their approach as 'devastating' to the notion that SGX could prevent an
adversarial OS from knowing what is going on inside of an enclave.

The conundrum is pretty simple and straight forward.  Either the
technology works, as advertised, which means, by definition, that the
operating system has no effective insight into what an enclave is
doing.

Or some of the kernel developers are right, and there is a way for the
OS to have effective insight and thus control, over what an enclave is
trying to do.  A fact that effectively implies that Fortanix, Asylo,
Enarx, Gramine, Oculum et.al. are peddling the equivalent of Security
Snake Oil when it comes to SGX enabled 'confidential' computing.

The above shouldn't be considered pejorative to those products,
companies or initiatives.  I have an acquaintance in the IT business
that tells me I worry too much about if things work and how, because
he has made a ton of money selling people stuff that he knows doesn't
work.

For the record, I'm completely ambivalent with respect to how any of
this gets done or what the PTE permissions for dynamic content are.
For those who may not be ambivalent about whether Linux gets security
'right', let me leave the following thoughts.

It hasn't been my experience that good engineers design things or
processes for the sake of designing them.  The architecture for
EDMM/SGX was proposed and presented in the form of two papers at
HASP-2016.

Let's see, the operating system 'flow' model counts as an author none
other then Mark Shanahan himself, with Bin Xing and Rebekah Hurd.

The SGX instructions and architecture paper was done by Frank McKeen,
Ilya Alexandrovich, Ittai Anati, Dror Capi, Simon Johnson, Rebekah
Hurd and Carlos Razos.

The interactions I've had left me feeling like these were really smart
people.  Maybe they were on psychedelics when they designed this and
wrote the papers?  It would seem to be helpful for these discussions
to know if this was the case.

Or maybe, perhaps, there are some subtleties, hidden 'gotchas',
micro-architectural pecularities and/or security considerations that
influenced the documented EDMM flow.  Seems like secure kernel
development would benefit from knowing that, rather then concluding
that this method is slow, and perhaps hard to implement, so Linux is
going to ignore these potential issues.

The EDMM papers, if anyone should happen to read them, indicate in the
acknowledgments that the design was done in collaboration with OS
designers.  I'm presuming that was Pienado's group at Microsoft
Research, given that is where Haven came from, maybe they were
dabbling with psychedelics.

I believe they did manage to document the early micro-architectural
errata about certain page access patterns causing processor faults.
That leads one to believe they couldn't have been too confused about
what was going on.

When I brought all of this up last time I was told I was trying to
present a 'scary boogeyman'.  That could be, I will leave that for
others to judge.

My pragmatic response to that accusation is why would we argue to have
systemd and the distro's change system behaviors to accomodate the
ability to apply an LSM to a 500K 'bootloader'.  When that
'bootloader' can turn around and potentially pull down gigabytes of
code that we appear to have decided don't need any controls applied to
whatsoever.

Caution would seem to suggest the need to understand the implications
of these issues a bit better than we currently do.

> Thank you.
> 
> BR, Jarkko

Best wishes for a pleasant weekend to everyone.

Dr. Greg

As always,
Dr. Greg Wettstein, Ph.D, Worker      Autonomously self-defensive
Enjellic Systems Development, LLC     IOT platforms and edge devices.
4206 N. 19th Ave.
Fargo, ND  58102
PH: 701-281-1686                      EMAIL: dg@enjellic.com
------------------------------------------------------------------------------
"Thinking implies disagreement; and disagreement implies
 non-conformity; and non-comformity implies heresy; and heresy implies
 disloyality -- so obviously thinking must be stopped"
                                -- [Call to Greatness, 1954]
                                   Adlai Stephenson
