Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE10C4BBC51
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 16:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237120AbiBRPjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 10:39:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237104AbiBRPjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 10:39:35 -0500
Received: from sa-prd-fep-043.btinternet.com (mailomta31-sa.btinternet.com [213.120.69.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F5B3DA52;
        Fri, 18 Feb 2022 07:39:16 -0800 (PST)
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
          by sa-prd-fep-043.btinternet.com with ESMTP
          id <20220218153915.FDKV18908.sa-prd-fep-043.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>;
          Fri, 18 Feb 2022 15:39:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1645198755; 
        bh=+UHLQG+M4ZifbAygCfGQKWqjXrpBKvOYPwDad48Ye9E=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=r7QVE9XU8T7BdxLPY+hgO6sw5NVmnMpGziVQBP+VeHw70cYF0/1bXtERlwqGhLKD2VK4+czItKDmYsy27Bl2+5JolwSggxOTzX0mLxpPsrHq8hiDNBWC2fy4EYJC2Ow4oSIsh/BNMZKzWbmsnLUrhExH+Q+qdKlEAuMZ9ZxeqNfKWB67sAO0pCV4DJOsJzosXLzVL7muwN/V9ulPiOVXS4/MRd/T4S3vWH/P/r7b51jgs3uLZKn+83xGysN/1HBdst3U9zHYY1eX/8DznPOwuFIEGwdQ+8JU/Ba6Rh8KomKDWSkbN6M4ZNKTcP+B85Pljny1mBivPuATe3hAmCU/UQ==
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=richard_c_haines@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 613943C616036884
X-Originating-IP: [86.183.97.183]
X-OWM-Source-IP: 86.183.97.183 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvvddrkedtgdejjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnheptdefkeefudffheegueffuddtveehheduheekudekvdegjeduhfeghfdvhffhuedtnecuffhomhgrihhnpehsvghlihhnuhigphhrohhjvggtthdrohhrghdprghnughrohhiugdrtghomhenucfkphepkeeirddukeefrdeljedrudekfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddrudelkegnpdhinhgvthepkeeirddukeefrdeljedrudekfedpmhgrihhlfhhrohhmpehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopegsihhllhdrtgdrrhhosggvrhhtshesghhmrghilhdrtghomhdprhgtphhtthhopegthhhpvggsvghniheslhhinhhugidrmhhitghrohhsohhfthdrtghomhdprhgtphhtthhopeguvghmihhosggvnhhouhhrsehgmhgrihhlrdgt
        ohhmpdhrtghpthhtohepughomhhinhhitghkrdhgrhhifhhtseguvghfvghnshgvtgdrnhhlpdhrtghpthhtohepvghprghrihhssehprghrihhsphhlrggtvgdrohhrghdprhgtphhtthhopehjvghffhhvsehgohhoghhlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehprghulhesphgruhhlqdhmohhorhgvrdgtohhmpdhrtghpthhtohepshgvlhhinhhugidqrhgvfhhpohhlihgthiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvghphhgvnhdrshhmrghllhgvhidrfihorhhksehgmhgrihhlrdgtohhm
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from [192.168.1.198] (86.183.97.183) by sa-prd-rgout-004.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as richard_c_haines@btinternet.com)
        id 613943C616036884; Fri, 18 Feb 2022 15:39:14 +0000
Message-ID: <141da74b176cd3bae74a8a81226c661c032631dc.camel@btinternet.com>
Subject: Re: [PATCH] SELinux: Always allow FIOCLEX and FIONCLEX
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Demi Marie Obenour <demiobenour@gmail.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     William Roberts <bill.c.roberts@gmail.com>,
        Dominick Grift <dominick.grift@defensec.nl>,
        Chris PeBenito <chpebeni@linux.microsoft.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        selinux-refpolicy@vger.kernel.org,
        Jeffrey Vander Stoep <jeffv@google.com>
Date:   Fri, 18 Feb 2022 15:39:10 +0000
In-Reply-To: <aca4f2d6-5e1a-8c20-bfde-17e436b7e9d8@gmail.com>
References: <4df50e95-6173-4ed1-9d08-3c1c4abab23f@gmail.com>
         <CAHC9VhSjTqT-4TMxBnQOQHkj+djONihfeoPVyy1egrZY2t10XA@mail.gmail.com>
         <c8a616e4-26a6-af51-212c-31dca0e265cd@gmail.com>
         <CAHC9VhQTZdeNOx3AXdoc9LXUzDk5n7wyGBX-tV-ZaovhPAdWwQ@mail.gmail.com>
         <e85dd38b-ef7b-ed7e-882e-124cdf942c44@gmail.com>
         <CAHC9VhROuJtvNHuVaR6pEekNFacH3Tywx58_hn1f5Mwk+kjC8g@mail.gmail.com>
         <b7e55304-d114-bcbe-08d2-b54828121a01@gmail.com>
         <CAHC9VhSdgD4Nfaxbnnn4r-OK8koSZ7+zQoPShDbGi9PvkJFpng@mail.gmail.com>
         <478e1651-a383-05ff-d011-6dda771b8ce8@linux.microsoft.com>
         <875ypt5zmz.fsf@defensec.nl>
         <CAFftDdo9JmbyPzPWRjOYgZBOS9b5d+OGKKf8egS8_ysbbWW87Q@mail.gmail.com>
         <CABXk95Az0V0qWyB0Cp9D+MaCKNBfcdk4=bvXRdm5EXzHdjXJJg@mail.gmail.com>
         <CAHC9VhQKuQuR1pJfa0h2Y5dCjmrpiYaGpymwxxE1sa6jR3h-bA@mail.gmail.com>
         <aca4f2d6-5e1a-8c20-bfde-17e436b7e9d8@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-02-17 at 18:55 -0500, Demi Marie Obenour wrote:
> On 2/15/22 15:34, Paul Moore wrote:
> > On Mon, Feb 14, 2022 at 2:11 AM Jeffrey Vander Stoep
> > <jeffv@google.com> wrote:
> > > On Tue, Feb 8, 2022 at 3:18 PM William Roberts
> > > <bill.c.roberts@gmail.com> wrote:
> > > > 
> > > > <snip>
> > > > 
> > > > This is getting too long for me.
> > > > 
> > > > > > 
> > > > > > I don't have a strong opinion either way.  If one were to
> > > > > > allow this
> > > > > > using a policy rule, it would result in a major policy
> > > > > > breakage.  The
> > > > > > rule would turn on extended perm checks across the entire
> > > > > > system,
> > > > > > which the SELinux Reference Policy isn't written for.  I
> > > > > > can't speak
> > > > > > to the Android policy, but I would imagine it would be the
> > > > > > similar
> > > > > > problem there too.
> > > > > 
> > > > > Excuse me if I am wrong but AFAIK adding a xperm rule does
> > > > > not turn on
> > > > > xperm checks across the entire system.
> > > > 
> > > > It doesn't as you state below its target + class.
> > > > 
> > > > > 
> > > > > If i am not mistaken it will turn on xperm checks only for
> > > > > the
> > > > > operations that have the same source and target/target class.
> > > > 
> > > > That's correct.
> > > > 
> > > > > 
> > > > > This is also why i don't (with the exception TIOSCTI for
> > > > > termdev
> > > > > chr_file) use xperms by default.
> > > > > 
> > > > > 1. it is really easy to selectively filter ioctls by adding
> > > > > xperm rules
> > > > > for end users (and since ioctls are often device/driver
> > > > > specific they
> > > > > know best what is needed and what not)
> > > > 
> > > > > > > > and FIONCLEX can be trivially bypassed unless
> > > > > > > > fcntl(F_SETFD)
> > > > > 
> > > > > 2. if you filter ioctls in upstream policy for example like i
> > > > > do with
> > > > > TIOSCTI using for example (allowx foo bar (ioctl chr_file
> > > > > (not
> > > > > (0xXXXX)))) then you cannot easily exclude additional ioctls
> > > > > later where source is
> > > > > foo and target/tclass is bar/chr_file because there is
> > > > > already a rule in
> > > > > place allowing the ioctl (and you cannot add rules)
> > > > 
> > > > Currently, fcntl flag F_SETFD is never checked, it's silently
> > > > allowed, but
> > > > the equivalent FIONCLEX and FIOCLEX are checked. So if you
> > > > wrote policy
> > > > to block the FIO*CLEX flags, it would be bypassable through
> > > > F_SETFD and
> > > > FD_CLOEXEC. So the patch proposed makes the FIO flags behave
> > > > like
> > > > F_SETFD. Which means upstream policy users could drop this
> > > > allow, which
> > > > could then remove the target/class rule and allow all icotls.
> > > > Which is easy
> > > > to prevent and fix you could be a rule in to allowx 0 as
> > > > documented in the
> > > > wiki: https://selinuxproject.org/page/XpermRules
> > > > 
> > > > The questions I think we have here are:
> > > > 1. Do we agree that the behavior between SETFD and the FIO
> > > > flags are equivalent?
> > > >   I think they are.
> > > > 2. Do we want the interfaces to behave the same?
> > > >   I think they should.
> > > > 3. Do upstream users of the policy construct care?
> > > >   The patch is backwards compat, but I don't want their to be
> > > > cruft
> > > > floating around with extra allowxperm rules.
> > > 
> > > I think this proposed change is fine from Android's perspective.
> > > It
> > > implements in the kernel what we've already already put in place
> > > in
> > > our policy - that all domains are allowed to use these IOCLTs.
> > > https://cs.android.com/android/platform/superproject/+/master:system/sepolicy/public/domain.te;l=312
> > > 
> > > It'll be a few years before we can clean up our policy since we
> > > need
> > > to support older kernels, but that's fine.
> > 
> > Thanks for the discussion everyone, it sounds like everybody is
> > okay
> > with the change - that's good.  However, as I said earlier in this
> > thread I think we need to put this behind a policy capability, how
> > does POLICYDB_CAPABILITY_IOCTL_CLOEXEC/"ioctl_skip_cloexec" sound
> > to
> > everyone?
> > 
> > Demi, are you able to respin this patch with policy capability
> > changes?
> 
> I can try, but this is something I am doing in my spare time and I
> have no idea what adding a policy capability would involve.  While I
> have written several policies myself, I believe this is the first
> time
> I have dealt with policy capabilities outside of kernel log output.
> So it will be a while before I can make a patch.  You would probably
> be
> able to write a patch far more quickly and easily.

RESEND: Forgot to add the updates for libsepol (I think it's complete
now)


# Adding A New Policy Capability

- [Kernel Updates](#kernel-updates)
- [*libsepol* Library Updates](#libsepol-library-updates)
- [Reference Policy Updates](#reference-policy-updates)

## Kernel Updates

In kernel source update the following three files with the new
capability:

***security/selinux/include/policycap_names.h***

Add new entry at end of this list:

```
/* Policy capability names */
const char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] = {
	...
	"genfs_seclabel_symlinks",
	"new_polcap_name"
};
```

***security/selinux/include/policycap.h***

Add new entry at end of this list:

```
/* Policy capabilities */
enum {
	...
	POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS,
	POLICYDB_CAPABILITY_NEW_POLCAP_NAME,
	__POLICYDB_CAPABILITY_MAX
};
```

***security/selinux/include/security.h***

Add a new entry that will initialise the new capability:

```
static inline bool selinux_policycap_new_name(void)
{
	struct selinux_state *state = &selinux_state;

	return READ_ONCE(state-
>policycap[POLICYDB_CAPABILITY_NEW_POLCAP_NAME]);
}
```

Finally in the updated code that utilises the new policy capabilty do
something like this:

```
if (selinux_policycap_new_name())
	do this;
else
	do that;
```

## *libsepol* Library Updates

In selinux userspace source update the following two files with the new
capability:

***selinux/libsepol/src/polcaps.c***

Add new entry at end of this list:

```
static const char * const polcap_names[] = {
	...
	"genfs_seclabel_symlinks",	/*
POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS */
	"new_polcap_name",		/*
POLICYDB_CAPABILITY_NEW_POLCAP_NAME */
	NULL
};
```

***selinux/libsepol/include/sepol/policydb/polcaps.h***

Add new entry at end of this list:

```
/* Policy capabilities */
enum {
	...
	POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS,
	POLICYDB_CAPABILITY_NEW_POLCAP_NAME,
	__POLICYDB_CAPABILITY_MAX
};
```

## Reference Policy Updates

The new policy capability entry is then added to the Reference Policy
file:

***policy/policy_capabilities***

An example entry that enables the capability in policy is:

```
# A description of the capability
policycap new_polcap_name;
```
To disable the capability in policy comment out the entry:

```
# A description of the capability
#policycap new_polcap_name;
```



