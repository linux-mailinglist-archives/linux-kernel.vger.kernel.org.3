Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20EEA5AA4B7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 02:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbiIBA4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 20:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234332AbiIBA4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 20:56:47 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CA5A346B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 17:56:46 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-11edd61a9edso1385006fac.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 17:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=Cm8x//sfvFO0babHLgWXLn4siXLBDZJX/lciSTmWoI0=;
        b=oSDLIJxsI5ChGICF8Jf9BYn83bl3RcvSrjTAR0iYGMxbQEr0oDA3dB9yMIngbU7+vJ
         xb/DV/8v69ZoGz7x9EdZzzG5WDzz672FT54380iLB/hg3BkdbiekUqmFWam8wvwrsNZH
         P7cg9GdwlBK3WIjBiU1XAtVqWfj35QC0h+WaicBle49DWLZv/0wu6Npjob9DQzOj18Pk
         LOo20UFp229opfl0R2OC25bWbrp2vBBnvNSkdwjzzGl7Nr9CDYIvbwtQamGTAZTFZ616
         xYKuIs6FzC5s0n5Ui8W2ZbR1UYgiOu55g0FHVoB3DOeq+H/6ODogXBH11hdTjzLrS5i2
         Rzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Cm8x//sfvFO0babHLgWXLn4siXLBDZJX/lciSTmWoI0=;
        b=I7ngK27NQzu4LYXeiG82T7XVXSBOSu4S/zSJ/vXrPScj8f9mZnRY0nV2ie3kPc7YEr
         fOEUqra7Zd4AdbzLEFDIy7SIZsW56+FdfgzUKMtLamuq8RRgDnmwyDtDILiicJPu4003
         9U/IJl+4PNpamRCsujWLs9Qn32g5/Ya4k+qhyyfja6VYMLRnW+zP1ZAyAVRO90325dsC
         4CH2P36cWujlw9K5Jhhiqx0Vn8feJ9jrnoL59t/qoeXYpWfuVJkJ9ygNZjFBigntU0Fk
         DApn5WPLkkUBginMFWQORi/88OF14QvXK1SCoE0S7d1I8SmnemiVBlf0QE1vwXAuOJ4w
         64TQ==
X-Gm-Message-State: ACgBeo22QCZJM8Kt60HWiiqgGv1yDGPnPAwZDncuIwDHRoicNWpEmhfw
        muo3JbombarYiDlmXcPRyTofpXAY4BGNJ+FLyNcG+Gz7L5l1
X-Google-Smtp-Source: AA6agR4wv7A4tIt2g3FPjtd3yPWz+7nAm93lFsMZOgdbY8OzdcPuiV9mw53vup71hnUT8Rg1icEFppKe/k6N9861Wfs=
X-Received: by 2002:a05:6808:3a9:b0:343:4b14:ccce with SMTP id
 n9-20020a05680803a900b003434b14cccemr885471oie.41.1662080205317; Thu, 01 Sep
 2022 17:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220502160030.131168-8-cgzones@googlemail.com>
 <20220615152623.311223-1-cgzones@googlemail.com> <20220615152623.311223-8-cgzones@googlemail.com>
In-Reply-To: <20220615152623.311223-8-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 1 Sep 2022 20:56:34 -0400
Message-ID: <CAHC9VhS8ASN+BB7adi=uoAj=LeNhiD4LEidbMc=_bcD3UTqabg@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] capability: add any wrapper to test for multiple
 caps with exactly one audit message
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, Serge Hallyn <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 11:27 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Add the interfaces `capable_any()` and `ns_capable_any()` as an
> alternative to multiple `capable()`/`ns_capable()` calls, like
> `capable_any(CAP_SYS_NICE, CAP_SYS_ADMIN)` instead of
> `capable(CAP_SYS_NICE) || capable(CAP_SYS_ADMIN)`.
>
> `capable_any()`/`ns_capable_any()` will in particular generate exactly
> one audit message, either for the left most capability in effect or, if
> the task has none, the first one.
>
> This is especially helpful with regard to SELinux, where each audit
> message about a not allowed capability will create an AVC denial.
> Using this function with the least invasive capability as left most
> argument (e.g. CAP_SYS_NICE before CAP_SYS_ADMIN) enables policy writers
> to only allow the least invasive one and SELinux domains pass this check
> with only capability:sys_nice or capability:sys_admin allowed without
> any AVC denial message.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> ---
> v3:
>    - rename to capable_any()
>    - fix typo in function documentation
>    - add ns_capable_any()
> v2:
>    avoid varargs and fix to two capabilities; capable_or3() can be added
>    later if needed
> ---
>  include/linux/capability.h | 10 +++++++
>  kernel/capability.c        | 53 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 63 insertions(+)

...

> diff --git a/kernel/capability.c b/kernel/capability.c
> index 765194f5d678..ab9b889c3f4d 100644
> --- a/kernel/capability.c
> +++ b/kernel/capability.c
> @@ -435,6 +435,59 @@ bool ns_capable_setid(struct user_namespace *ns, int=
 cap)
>  }
>  EXPORT_SYMBOL(ns_capable_setid);
>
> +/**
> + * ns_capable_any - Determine if the current task has one of two superio=
r capabilities in effect
> + * @ns:  The usernamespace we want the capability in
> + * @cap1: The capabilities to be tested for first
> + * @cap2: The capabilities to be tested for secondly
> + *
> + * Return true if the current task has at least one of the two given sup=
erior
> + * capabilities currently available for use, false if not.
> + *
> + * In contrast to or'ing capable() this call will create exactly one aud=
it
> + * message, either for @cap1, if it is granted or both are not permitted=
,
> + * or @cap2, if it is granted while the other one is not.
> + *
> + * The capabilities should be ordered from least to most invasive, i.e. =
CAP_SYS_ADMIN last.
> + *
> + * This sets PF_SUPERPRIV on the task if the capability is available on =
the
> + * assumption that it's about to be used.
> + */
> +bool ns_capable_any(struct user_namespace *ns, int cap1, int cap2)
> +{
> +       if (ns_capable_noaudit(ns, cap1))
> +               return ns_capable(ns, cap1);
> +
> +       if (ns_capable_noaudit(ns, cap2))
> +               return ns_capable(ns, cap2);
> +
> +       return ns_capable(ns, cap1);

I'm slightly concerned that some people are going to be upset about
making an additional call into the capabilities code with this
function.  I think we need to be a bit more clever here to take out
some of the extra work.

I wonder if we create a new capability function, call it
ns_capable_audittrue(...) or something like that, that only generates
an audit record if the current task has the requested capability; if
the current task does not have the requested capability no audit
record is generated.  With this new function I think we could rewrite
ns_capable_any(...) like this:

  bool ns_capable_any(ns, cap1, cap2)
  {
    if (ns_capable_audittrue(ns, cap1))
      return true;
    if (ns_capable_audittrue(ns, cap2))
      return true;
    return ns_capable(ns, cap1);
  }

... we would still have an extra capability check in the failure case,
but that's an error case anyway and not likely to draw much concern.

Of course this would require some additional work, meaning a new
CAP_OPT_XXX flag (CAP_OPT_AUDITTRUE?), and updates to the individual
LSMs.  However, the good news here is that it appears only SELinux and
AppArmor would need modification (the others don't care about
capabilities or audit) and in each case the modification to support
the new CAP_OPT_AUDITTRUE flag look pretty simple.

Thoughts?

> +}
> +EXPORT_SYMBOL(ns_capable_any);

--=20
paul-moore.com
