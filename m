Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5B95B1324
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 06:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiIHEII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 00:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiIHEIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 00:08:05 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12E0B515C;
        Wed,  7 Sep 2022 21:08:04 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q63so15507702pga.9;
        Wed, 07 Sep 2022 21:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=WDHDco1ME1kp63nAFCVLvw8uKReZNIKLpXHBwYYZT9A=;
        b=eVjQHuScev8qPeYVLUSB1aeXdKmI8LYZ1Q68rXlO4+tIBtOjWPcR1swvcPfzRNXJoF
         N4x6K/pJzFTE7vStCtcur57Q+MjovscFuzYsL2rYQxPif52ey0e2pRW3XowoAZe+ib/H
         vCgGOyY0WHFYf1pXm3VSdW9vjHWJaXtTyceZU3T0bb+ZA/PnvTDChXJTg2t5it86LwJP
         3BsDEHwAgn6Mv4NON1StaC0txXTOlk1tDSLMquQJoaUx7LUSH8XPP9Qp6ms72W7xitGA
         AWIoMLhfFyDVP+VloOWFx/Rpp3UP+DI6lRSVi8xxCt8NV7+nptfz38K0jUwktwX6OTx8
         KUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=WDHDco1ME1kp63nAFCVLvw8uKReZNIKLpXHBwYYZT9A=;
        b=4reuA25i6Bu4XMOEAl3IwRsGG28D9aNhXXoXZIYNX2r8m1/hiuMt32D4h4TKB+vaqv
         /RVqglwWaQ9DkeEOQvWW5swdsAZ+Tu0dAI/jm3EjtGShw8hK3wDlMUWBsEHlHD2S35eX
         Vi9nYIeYLGVO73TZadYWa+G0SeWnp4tCZCkMTvnIZdPPKihKS2+ebO2N+LMBdBgD5ljz
         ysDwrqU+i05xtcIfvxnF5AzmI/OXZ2DsFkjWknoBWbvE9J+DieRCw1fk4i7m5WprWk2P
         OMQbnHyOHOP2LZHhpPLdIWJmWBwEAkkktgBNf5fwclK4o6QQGzBq1SZKNDAAyqZgoyTH
         C2ZA==
X-Gm-Message-State: ACgBeo22O8OHHcjsrvc5xLQQpDCHCJl2pFUO2Jhpmw2U2xLLWI3zh6uv
        Ob2op31NVxLI7wjKxnZ6q+c=
X-Google-Smtp-Source: AA6agR7KdYwTWGxNx+ZcM0/CPJ7ZlS1H4M18Hj2P1sflzt+HSCqIzyuUoOMxG7urfULOOlZgetdgcw==
X-Received: by 2002:a05:6a00:124d:b0:538:295a:1c47 with SMTP id u13-20020a056a00124d00b00538295a1c47mr7334243pfi.5.1662610084334;
        Wed, 07 Sep 2022 21:08:04 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-94.three.co.id. [180.214.232.94])
        by smtp.gmail.com with ESMTPSA id oa11-20020a17090b1bcb00b002007b60e288sm568745pjb.23.2022.09.07.21.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 21:08:03 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id BC9D4103D97; Thu,  8 Sep 2022 11:07:59 +0700 (WIB)
Date:   Thu, 8 Sep 2022 11:07:59 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Babu Moger <babu.moger@amd.com>
Cc:     corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, fenghua.yu@intel.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Subject: Re: [PATCH v4 13/13] Documentation/x86: Update resctrl_ui.rst for
 new features
Message-ID: <Yxlqn0C8rDsLUHNv@debian.me>
References: <166257348081.1043018.11227924488792315932.stgit@bmoger-ubuntu>
 <166257368995.1043018.8665350782054895088.stgit@bmoger-ubuntu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mBYbnV23ZAQONOAr"
Content-Disposition: inline
In-Reply-To: <166257368995.1043018.8665350782054895088.stgit@bmoger-ubuntu>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mBYbnV23ZAQONOAr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 07, 2022 at 01:01:29PM -0500, Babu Moger wrote:
> Update the documentation for the new features:
> 1. Slow Memory Bandwidth allocation (SMBA).
>    With this feature, the QOS  enforcement policies can be applied
>    to the external slow memory connected to the host. QOS enforcement
>    is accomplished by assigning a Class Of Service (COS) to a processor
>    and specifying allocations or limits for that COS for each resource
>    to be allocated.
>=20
> 2. Bandwidth Monitoring Event Configuration (BMEC).
>    The bandwidth monitoring events mbm_total_bytes and mbm_local_bytes
>    are set to count all the total and local reads/writes respectively.
>    With the introduction of slow memory, the two counters are not
>    enough to count all the different types are memory events. With the
>    feature BMEC, the users have the option to configure mbm_total_bytes
>    and mbm_local_bytes to count the specific type of events.
>=20
> Also add configuration instructions with examples.
>=20
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  Documentation/x86/resctrl.rst |  148 +++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 146 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
> index 71a531061e4e..56581587c1a3 100644
> --- a/Documentation/x86/resctrl.rst
> +++ b/Documentation/x86/resctrl.rst
> @@ -17,14 +17,16 @@ AMD refers to this feature as AMD Platform Quality of=
 Service(AMD QoS).
>  This feature is enabled by the CONFIG_X86_CPU_RESCTRL and the x86 /proc/=
cpuinfo
>  flag bits:
> =20
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>  RDT (Resource Director Technology) Allocation	"rdt_a"
>  CAT (Cache Allocation Technology)		"cat_l3", "cat_l2"
>  CDP (Code and Data Prioritization)		"cdp_l3", "cdp_l2"
>  CQM (Cache QoS Monitoring)			"cqm_llc", "cqm_occup_llc"
>  MBM (Memory Bandwidth Monitoring)		"cqm_mbm_total", "cqm_mbm_local"
>  MBA (Memory Bandwidth Allocation)		"mba"
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +SMBA (Slow Memory Bandwidth Allocation)		"smba"
> +BMEC (Bandwidth Monitoring Event Configuration) "bmec"
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> =20
>  To use the feature mount the file system::
> =20
> @@ -161,6 +163,23 @@ with the following files:
>  "mon_features":
>  		Lists the monitoring events if
>  		monitoring is enabled for the resource.
> +                Example output:
> +
> +                # cat /sys/fs/resctrl/info/L3_MON/mon_features
> +                llc_occupancy
> +                mbm_total_bytes
> +                mbm_local_bytes
> +
> +                If the system supports Bandwidth Monitoring Event
> +                Configuration (BMEC), then the bandwidth events will
> +                be configurable. Then the output will be.
> +
> +                # cat /sys/fs/resctrl/info/L3_MON/mon_features
> +                llc_occupancy
> +                mbm_total_bytes
> +                mbm_total_config
> +                mbm_local_bytes
> +                mbm_local_config
> =20
Use code blocks for terminal output above:

---- >8 ----
t a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
index 56581587c1a331..6474cf655792bf 100644
--- a/Documentation/x86/resctrl.rst
+++ b/Documentation/x86/resctrl.rst
@@ -163,23 +163,23 @@ with the following files:
 "mon_features":
 		Lists the monitoring events if
 		monitoring is enabled for the resource.
-                Example output:
+                Example::
=20
-                # cat /sys/fs/resctrl/info/L3_MON/mon_features
-                llc_occupancy
-                mbm_total_bytes
-                mbm_local_bytes
+                   # cat /sys/fs/resctrl/info/L3_MON/mon_features
+                   llc_occupancy
+                   mbm_total_bytes
+                   mbm_local_bytes
=20
                 If the system supports Bandwidth Monitoring Event
                 Configuration (BMEC), then the bandwidth events will
-                be configurable. Then the output will be.
+                be configurable. The output will be::
=20
-                # cat /sys/fs/resctrl/info/L3_MON/mon_features
-                llc_occupancy
-                mbm_total_bytes
-                mbm_total_config
-                mbm_local_bytes
-                mbm_local_config
+                   # cat /sys/fs/resctrl/info/L3_MON/mon_features
+                   llc_occupancy
+                   mbm_total_bytes
+                   mbm_total_config
+                   mbm_local_bytes
+                   mbm_local_config
=20
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in

> +        Following are the types of events supported:
> +
> +        =3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +        Bits    Description
> +        =3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +        6       Dirty Victims from the QOS domain to all types of memory
> +        5       Reads to slow memory in the non-local NUMA domain
> +        4       Reads to slow memory in the local NUMA domain
> +        3       Non-temporal writes to non-local NUMA domain
> +        2       Non-temporal writes to local NUMA domain
> +        1       Reads to memory in the non-local NUMA domain
> +        0       Reads to memory in the local NUMA domain
> +        =3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +

The table above looks OK.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--mBYbnV23ZAQONOAr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYxlqmAAKCRD2uYlJVVFO
o8IYAQCRiGQSsGMwJQ41qfcHFjEW5KgsFxORXsuACBFHmC4I6gEA6PAjuvMBG7p8
I0qGiGptjY6qv61XHvakeps6DWzwlwY=
=GTK/
-----END PGP SIGNATURE-----

--mBYbnV23ZAQONOAr--
