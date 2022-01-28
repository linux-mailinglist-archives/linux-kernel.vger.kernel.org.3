Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146D749F0B1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 02:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345164AbiA1BrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 20:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235404AbiA1BrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 20:47:21 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9667AC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 17:47:20 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a8so10653947ejc.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 17:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V0cjl1ygvMZTU8IsBNMqY3QLwdA/2X7ytI4Oe8O1ZsE=;
        b=VfY0mqoAeJ6pwM2nCCc1n0IXtPATIH0t1JxwCzpK9RQFv77yYY7m7E4wqz/+7G2vZD
         bZAZbs39epUh02d2qBhekQDUgDoTIpdVhLEh7QQJEH19ELXa1z9zwnuXyL0zdoC4r9xo
         SuH0WHsW10OdlEkzFyM92z9squlr/w9jXKoVGb+ZSZYcNpfOM/B1j4vSGBDUMLZQed99
         wjB8ovVAE1z2h2omS+J8cHNRDToLRqDc3f3XMhpQsFevxnGWG9xVjLUrQTNtKf0aH8vW
         MmUMZ5yIsB/+tHDLQ3Sd0Dm00efhX2PNCa/kjsFk1nGxxFwPMapYrIODsPpFqkUBYOol
         htQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V0cjl1ygvMZTU8IsBNMqY3QLwdA/2X7ytI4Oe8O1ZsE=;
        b=EODg/N9P1/OEY3PZRq10ByNQQpEcRsgDuSRquyNMQuBGPcV/MC7LabC6hJ1xgh1t2C
         eg7H6oGBMg1XCZ2vzBpxs3nLf9eTMyBhela77241GYvuNz1mJY2DceExkDuvcDBUPfj7
         vLiZaYZu34nouJN6TWo4M3p/HZ9xMZrGrCjgB7wo63wwHCahfH9DpKjkElmzq9swQ141
         nqfG313zRhiyRe6g9NCjkkPH2b+XgKKSnN52O4yJ5YFECLpKTRnbp5S888nDzHYGfedR
         Pzwvf/89ayURr7H1kFHKkorRzBMfRMGX7cbk24KvEZo7n2X18I27wZg4zLvGumnn2U4Q
         RKwA==
X-Gm-Message-State: AOAM531iGl36oicLbCNUJDKzaxonUP6AfzvMMHdfx6GqR6f0wpisTTXx
        Zgx0dQXdXfoFrU2jYD+1UPm5wCBipPoZhkDUzkJZ
X-Google-Smtp-Source: ABdhPJwCuk7Q91A40pglP5RK4LzbfGEY7S4Y1paT5rqTW07Jisx7QtQXrE8Uq1xNwQ8zjOCnCh3ZOdtfRJ0LWirpcx4=
X-Received: by 2002:a17:907:7f29:: with SMTP id qf41mr5069085ejc.12.1643334439141;
 Thu, 27 Jan 2022 17:47:19 -0800 (PST)
MIME-Version: 1.0
References: <20220125145931.56831-1-cgzones@googlemail.com>
 <CAHC9VhTCf4L9rif-+7gTK64JoUiDv28DFwS1vUsvzv8rG+JCuQ@mail.gmail.com> <8ea4d17a-f2fd-b6a5-b988-0edbc63022f6@ieee.org>
In-Reply-To: <8ea4d17a-f2fd-b6a5-b988-0edbc63022f6@ieee.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 27 Jan 2022 20:47:08 -0500
Message-ID: <CAHC9VhQE4B89ybnGooy599CVoA7aLd06jUkSZoWAYZWgD=BT8A@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: split no transition execve check
To:     Chris PeBenito <pebenito@ieee.org>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Xiong Zhenwu <xiong.zhenwu@zte.com.cn>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 8:42 AM Chris PeBenito <pebenito@ieee.org> wrote:
> On 1/26/22 17:51, Paul Moore wrote:
> > On Tue, Jan 25, 2022 at 9:59 AM Christian G=C3=B6ttsche
> > <cgzones@googlemail.com> wrote:
> >>
> >> In case a setuid or setgid binary is mislabeled with a generic context=
,
> >> either via a policy mistake or a move by the distribution package,
> >> executing it will be checked by the file permission execute_no_trans o=
n
> >> the generic file context (e.g. bin_t).  The setuid(2)/setgid(2) syscal=
l
> >> within will then be checked against the unchanged caller process
> >> context, which might have been granted the capability permission setui=
d/
> >> setgid to initially drop privileges.  To avoid that scenario split the
> >> execute_no_trans permission in case of a setuid/setgid binary into a n=
ew
> >> permission execute_sxid_no_trans.
> >>
> >> For backward compatibility this behavior is contained in a new policy
> >> capability.
> >>
> >> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >> ---
> >>   security/selinux/hooks.c                   | 9 ++++++++-
> >>   security/selinux/include/classmap.h        | 2 +-
> >>   security/selinux/include/policycap.h       | 1 +
> >>   security/selinux/include/policycap_names.h | 3 ++-
> >>   security/selinux/include/security.h        | 8 ++++++++
> >>   5 files changed, 20 insertions(+), 3 deletions(-)
> >
> > Adding the refpolicy list to this thread as their opinion seems
> > particularly relevant to this discussion.
> >
> > FWIW, this looks reasonable to me but I would like to hear what others
> > have to say.
>
> I think this a band-aid to cover up the real problem, which is the mislab=
eled files.

It's hard to disagree with that, and the kernel is probably the wrong
place to apply a band-aid unless it is the only option left.

> >> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> >> index 5b6895e4fc29..b825fee39a70 100644
> >> --- a/security/selinux/hooks.c
> >> +++ b/security/selinux/hooks.c
> >> @@ -2348,9 +2348,16 @@ static int selinux_bprm_creds_for_exec(struct l=
inux_binprm *bprm)
> >>          ad.u.file =3D bprm->file;
> >>
> >>          if (new_tsec->sid =3D=3D old_tsec->sid) {
> >> +               u32 perm;
> >> +
> >> +               if (selinux_policycap_execute_sxid_no_trans() && is_sx=
id(inode->i_mode))
> >> +                       perm =3D FILE__EXECUTE_SXID_NO_TRANS;
> >> +               else
> >> +                       perm =3D FILE__EXECUTE_NO_TRANS;
> >> +
> >>                  rc =3D avc_has_perm(&selinux_state,
> >>                                    old_tsec->sid, isec->sid,
> >> -                                 SECCLASS_FILE, FILE__EXECUTE_NO_TRAN=
S, &ad);
> >> +                                 SECCLASS_FILE, perm, &ad);
> >>                  if (rc)
> >>                          return rc;
> >>          } else {
> >> diff --git a/security/selinux/include/classmap.h b/security/selinux/in=
clude/classmap.h
> >> index 35aac62a662e..53a1eeeb86fb 100644
> >> --- a/security/selinux/include/classmap.h
> >> +++ b/security/selinux/include/classmap.h
> >> @@ -65,7 +65,7 @@ struct security_class_mapping secclass_map[] =3D {
> >>              "quotaget", "watch", NULL } },
> >>          { "file",
> >>            { COMMON_FILE_PERMS,
> >> -           "execute_no_trans", "entrypoint", NULL } },
> >> +           "execute_no_trans", "entrypoint", "execute_sxid_no_trans",=
 NULL } },
> >>          { "dir",
> >>            { COMMON_FILE_PERMS, "add_name", "remove_name",
> >>              "reparent", "search", "rmdir", NULL } },
> >> diff --git a/security/selinux/include/policycap.h b/security/selinux/i=
nclude/policycap.h
> >> index 2ec038efbb03..23929dc3e1db 100644
> >> --- a/security/selinux/include/policycap.h
> >> +++ b/security/selinux/include/policycap.h
> >> @@ -11,6 +11,7 @@ enum {
> >>          POLICYDB_CAPABILITY_CGROUPSECLABEL,
> >>          POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
> >>          POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS,
> >> +       POLICYDB_CAPABILITY_EXECUTE_SXID_NO_TRANS,
> >>          __POLICYDB_CAPABILITY_MAX
> >>   };
> >>   #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
> >> diff --git a/security/selinux/include/policycap_names.h b/security/sel=
inux/include/policycap_names.h
> >> index b89289f092c9..4c014c2cf352 100644
> >> --- a/security/selinux/include/policycap_names.h
> >> +++ b/security/selinux/include/policycap_names.h
> >> @@ -12,7 +12,8 @@ const char *selinux_policycap_names[__POLICYDB_CAPAB=
ILITY_MAX] =3D {
> >>          "always_check_network",
> >>          "cgroup_seclabel",
> >>          "nnp_nosuid_transition",
> >> -       "genfs_seclabel_symlinks"
> >> +       "genfs_seclabel_symlinks",
> >> +       "execute_sxid_no_trans",
> >>   };
> >>
> >>   #endif /* _SELINUX_POLICYCAP_NAMES_H_ */
> >> diff --git a/security/selinux/include/security.h b/security/selinux/in=
clude/security.h
> >> index ac0ece01305a..ab95241b6b7b 100644
> >> --- a/security/selinux/include/security.h
> >> +++ b/security/selinux/include/security.h
> >> @@ -219,6 +219,14 @@ static inline bool selinux_policycap_genfs_seclab=
el_symlinks(void)
> >>          return READ_ONCE(state->policycap[POLICYDB_CAPABILITY_GENFS_S=
ECLABEL_SYMLINKS]);
> >>   }
> >>
> >> +static inline bool selinux_policycap_execute_sxid_no_trans(void)
> >> +{
> >> +       struct selinux_state *state =3D &selinux_state;
> >> +
> >> +       return READ_ONCE(state->policycap[POLICYDB_CAPABILITY_EXECUTE_=
SXID_NO_TRANS]);
> >> +}
> >> +
> >> +
> >>   struct selinux_policy_convert_data;
> >>
> >>   struct selinux_load_state {
> >> --
> >> 2.34.1
> >>
> >
> >
>
>
> --
> Chris PeBenito



--=20
paul-moore.com
