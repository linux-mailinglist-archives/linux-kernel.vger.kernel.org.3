Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0885B18D6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 11:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiIHJgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 05:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIHJgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 05:36:43 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760D34D819;
        Thu,  8 Sep 2022 02:36:42 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id bh13so16201086pgb.4;
        Thu, 08 Sep 2022 02:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=H+m2ewlqCCq95CTgb1OHmBjXlEDwPuPSJxmvMbooqnY=;
        b=gEyNGOXT010lySrOLxp9f1lEV0BNBgKehPKlE8AJFfDX9C1vNuHRLrHCKifUEAXhkh
         gKYviM/MnqLzVZobJm4RzPxDDWATEKuWiJ1c4U413zgz9e8MOvNhq0YHnteYD50hqO1u
         DR21wikum5B7Izke31cf0OpQM6HMerx/KJfkroDqmB7xtsPQJQ6iV1Rv3kjCvdC3O+oO
         VQp13pAIgL1O8u2+R0kuG0M+Y5SmxZFUjGiR1ySgi/a0tNO08rb2wsR40YgQNxgUobo7
         jHyPEdCKWCJToM9SMH7ibp9VW8YIzwYqWELZD3P2ouSPyM0DkEJD6YqP7SgmPiKJGvRz
         ADFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=H+m2ewlqCCq95CTgb1OHmBjXlEDwPuPSJxmvMbooqnY=;
        b=Ick53UVHvk4bGl8GfdzLtzsVXl/y/neJUkuViKaj6+x0NEgxATb6PuU8ZGuK78Lm6M
         4d+6tbvMEj0btmEws8rb7oTBC/HGQmFSJBjc0UCuKZw1arieumkhtf1MT1rr1Vs6auzd
         imXIvcj4H3gtNQmJtTFUPND2uprhe3bxR373wsqT+x7ppgJC46OZzxP+w8nYZWkFpJgb
         yijWZEWCtnyI+ElJIvQHL9DNBMz4CRz98WG312UCF9Q0aZ8ZPnXXEto/IwMAK8zSbEas
         ZFT4pYq0xTjuA2jlHfdlvEnEkpxZgaP8xPoZb9n79RuDO9LftYRPTrq6gU10WCHEh51M
         omhg==
X-Gm-Message-State: ACgBeo2k/+P8QRdEPMt7qeKLjmYTVyN5AD9ES1HdhofJAFyTnvwyiyhU
        KZITd3VSOBJXCk6+uGRLviQ=
X-Google-Smtp-Source: AA6agR7nul2gPA+ZBmM/QS1AbeuMbpEHXaT12rXXv16fg9yBoKyOa4EQQPqGEWr1wbNK4/6owLzcEg==
X-Received: by 2002:a65:42cc:0:b0:431:af8c:77e1 with SMTP id l12-20020a6542cc000000b00431af8c77e1mr7018308pgp.308.1662629802020;
        Thu, 08 Sep 2022 02:36:42 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-33.three.co.id. [116.206.12.33])
        by smtp.gmail.com with ESMTPSA id oa14-20020a17090b1bce00b0020255f4960bsm1295513pjb.24.2022.09.08.02.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 02:36:41 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 0768B1009E5; Thu,  8 Sep 2022 16:26:40 +0700 (WIB)
Date:   Thu, 8 Sep 2022 16:26:40 +0700
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
Message-ID: <Yxm1UJzpjW+AjXzQ@debian.me>
References: <166257348081.1043018.11227924488792315932.stgit@bmoger-ubuntu>
 <166257368995.1043018.8665350782054895088.stgit@bmoger-ubuntu>
 <Yxlqn0C8rDsLUHNv@debian.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Rbj7V0w5G8TJEeMh"
Content-Disposition: inline
In-Reply-To: <Yxlqn0C8rDsLUHNv@debian.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Rbj7V0w5G8TJEeMh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 08, 2022 at 11:07:59AM +0700, Bagas Sanjaya wrote:
> Use code blocks for terminal output above:
>=20
> ---- >8 ----
> t a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
> index 56581587c1a331..6474cf655792bf 100644
> --- a/Documentation/x86/resctrl.rst
> +++ b/Documentation/x86/resctrl.rst
> @@ -163,23 +163,23 @@ with the following files:
>  "mon_features":
>  		Lists the monitoring events if
>  		monitoring is enabled for the resource.
> -                Example output:
> +                Example::
> =20
> -                # cat /sys/fs/resctrl/info/L3_MON/mon_features
> -                llc_occupancy
> -                mbm_total_bytes
> -                mbm_local_bytes
> +                   # cat /sys/fs/resctrl/info/L3_MON/mon_features
> +                   llc_occupancy
> +                   mbm_total_bytes
> +                   mbm_local_bytes
> =20
>                  If the system supports Bandwidth Monitoring Event
>                  Configuration (BMEC), then the bandwidth events will
> -                be configurable. Then the output will be.
> +                be configurable. The output will be::
> =20
> -                # cat /sys/fs/resctrl/info/L3_MON/mon_features
> -                llc_occupancy
> -                mbm_total_bytes
> -                mbm_total_config
> -                mbm_local_bytes
> -                mbm_local_config
> +                   # cat /sys/fs/resctrl/info/L3_MON/mon_features
> +                   llc_occupancy
> +                   mbm_total_bytes
> +                   mbm_total_config
> +                   mbm_local_bytes
> +                   mbm_local_config

Hi Babu,

The suggestion diff above looks corrupted, so here is the proper one:

---- >8 ----
diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
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

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--Rbj7V0w5G8TJEeMh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYxm1SgAKCRD2uYlJVVFO
o++FAQDR8ikyW6Dg6ZO9t0YgQVNQ0Z1XvyEzj6zlFdhjb+SOJgEAuGJhLDonPQIq
t5C/8Lgk700EIeX7xt6Y8VJwERe/YAk=
=BZYG
-----END PGP SIGNATURE-----

--Rbj7V0w5G8TJEeMh--
