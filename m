Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA0D5B0AF3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 19:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiIGRD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 13:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiIGRD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 13:03:56 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05F2BB688
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 10:03:54 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1278624b7c4so19353140fac.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 10:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=wsH3q90wxx3Xx6OXO6OMT3se+Z7F0kym24QrbfBKhlM=;
        b=DFqXovpQHjSoy4gHgwBVnJLZ89TaBFOkTY9V7kC9xie2NDfamyJO18cRoCGh6KIY5F
         eJQLktqqHgtvDxFx9YHIXV1a7HJyoZL0iv2blmamlIT3r55w5x0/MlZj58bvfWVmG7sr
         3/sCKRCXWZMEvOD6AmkNKaw3WUCiGIqRliZZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=wsH3q90wxx3Xx6OXO6OMT3se+Z7F0kym24QrbfBKhlM=;
        b=hEp/3jupyLzDqFnLiH2xQ911DhdVWNHJk2YrjZB8/kd83knnCBThMwt7dmqTh8mwL3
         GRKrawCJPmjnmJAEZ/tMckioeRjmqBbF4JnUWW+k6aG4Pv3hrDQ3mkoXT2kUibJ7MQjn
         DWkd5qgyEubrpjsbUHWavW+/wF/v8CeSFZxQge2po1UwAJJabY4FjvmUla6MyRWwiBQx
         ThWJAD6hOSFDGQ7UiTNF5vbn2+vFkc88bN0tfZc608a5Nj7zfC0YuNsJjPqeUpruJ1XY
         RU4GT5csbj19rgXJUaqRO1CDzmcZL87sYewzYvE9MPMVGC/21KBcrUG+6UuuBh8gzgaf
         m8tQ==
X-Gm-Message-State: ACgBeo1KHzLZHg0QzD0QiCu9Wjy8n9YuNzgZyUTHDNKaW8JYqdEOBPvm
        Dgsz0OAGSWu5VUlt+hWDTXcKjjF+P6HQ5Q==
X-Google-Smtp-Source: AA6agR7GW0qHV4G7Y47RlR1jmyk4cGF2p3mpmBNnyZs703q00xqvYdF3ySHkU8FONCy2t4iqpIP++w==
X-Received: by 2002:a05:6870:783:b0:11c:7d1c:6ede with SMTP id en3-20020a056870078300b0011c7d1c6edemr2250552oab.239.1662570232218;
        Wed, 07 Sep 2022 10:03:52 -0700 (PDT)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com. [209.85.210.54])
        by smtp.gmail.com with ESMTPSA id w8-20020a4a2748000000b0044897475dd0sm5239653oow.43.2022.09.07.10.03.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 10:03:51 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id d18-20020a9d72d2000000b0063934f06268so10722286otk.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 10:03:51 -0700 (PDT)
X-Received: by 2002:a05:6830:58:b0:637:1974:140a with SMTP id
 d24-20020a056830005800b006371974140amr1823656otp.362.1662570231101; Wed, 07
 Sep 2022 10:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220823222526.1524851-1-evgreen@chromium.org>
 <20220823152108.v2.2.I9ded8c8caad27403e9284dfc78ad6cbd845bc98d@changeid> <Ywg3r5bJs+5QAll0@kernel.org>
In-Reply-To: <Ywg3r5bJs+5QAll0@kernel.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 7 Sep 2022 10:03:15 -0700
X-Gmail-Original-Message-ID: <CAE=gft7qCcpL002Cdo==r=vaDzjwMvEp=scbeKzJVG2ZZms+jQ@mail.gmail.com>
Message-ID: <CAE=gft7qCcpL002Cdo==r=vaDzjwMvEp=scbeKzJVG2ZZms+jQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] tpm: Allow PCR 23 to be restricted to
 kernel-only use
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Matthew Garrett <mgarrett@aurora.tech>, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        apronin@chromium.org, Daniil Lunev <dlunev@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 8:02 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Tue, Aug 23, 2022 at 03:25:18PM -0700, Evan Green wrote:
> > From: Matthew Garrett <matthewgarrett@google.com>
> >
> > Under certain circumstances it might be desirable to enable the creation
> > of TPM-backed secrets that are only accessible to the kernel. In an
> > ideal world this could be achieved by using TPM localities, but these
> > don't appear to be available on consumer systems. An alternative is to
> > simply block userland from modifying one of the resettable PCRs, leaving
> > it available to the kernel. If the kernel ensures that no userland can
> > access the TPM while it is carrying out work, it can reset PCR 23,
> > extend it to an arbitrary value, create or load a secret, and then reset
> > the PCR again. Even if userland somehow obtains the sealed material, it
> > will be unable to unseal it since PCR 23 will never be in the
> > appropriate state.
> >
> > From: Matthew Garrett <mjg59@google.com>
> > Signed-off-by: Matthew Garrett <mjg59@google.com>
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
>
> Same issues as the other patch.
>
> > ---
> > Matthew's original version of this patch is at:
> > https://patchwork.kernel.org/patch/12096491/
>
> Suggestion: find a lore URL instead for Matthew's patch,
> and then add "Link: <lore URL>" to your commit before
> sob's. It's a useful reference also in the commit log.
>
> >
> > Changes in v2:
> >  - Fixed sparse warnings
> >
> >  drivers/char/tpm/Kconfig          | 10 +++++++++
> >  drivers/char/tpm/tpm-dev-common.c |  8 +++++++
> >  drivers/char/tpm/tpm.h            | 21 +++++++++++++++++++
> >  drivers/char/tpm/tpm1-cmd.c       | 35 +++++++++++++++++++++++++++++++
> >  drivers/char/tpm/tpm2-cmd.c       | 22 +++++++++++++++++++
> >  drivers/char/tpm/tpm2-space.c     |  2 +-
> >  6 files changed, 97 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> > index 927088b2c3d3f2..4483b61a428b11 100644
> > --- a/drivers/char/tpm/Kconfig
> > +++ b/drivers/char/tpm/Kconfig
> > @@ -211,4 +211,14 @@ config TCG_FTPM_TEE
> >         This driver proxies for firmware TPM running in TEE.
> >
> >  source "drivers/char/tpm/st33zp24/Kconfig"
> > +
> > +config TCG_TPM_RESTRICT_PCR
> > +     bool "Restrict userland access to PCR 23"
> > +     depends on TCG_TPM
> > +     help
> > +       If set, block userland from extending or resetting PCR 23. This
> > +       allows it to be restricted to in-kernel use, preventing userland
> > +       from being able to make use of data sealed to the TPM by the kernel.
> > +       This is required for secure hibernation support, but should be left
> > +       disabled if any userland may require access to PCR23.
> >  endif # TCG_TPM
> > diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
> > index dc4c0a0a512903..7a4e618c7d1942 100644
> > --- a/drivers/char/tpm/tpm-dev-common.c
> > +++ b/drivers/char/tpm/tpm-dev-common.c
> > @@ -198,6 +198,14 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
> >       priv->response_read = false;
> >       *off = 0;
> >
> > +     if (priv->chip->flags & TPM_CHIP_FLAG_TPM2)
> > +             ret = tpm2_cmd_restricted(priv->chip, priv->data_buffer, size);
> > +     else
> > +             ret = tpm1_cmd_restricted(priv->chip, priv->data_buffer, size);
> > +
> > +     if (ret)
> > +             goto out;
> > +
> >       /*
> >        * If in nonblocking mode schedule an async job to send
> >        * the command return the size.
> > diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> > index a80b341d38eb8c..077c3ca0a127ba 100644
> > --- a/drivers/char/tpm/tpm.h
> > +++ b/drivers/char/tpm/tpm.h
> > @@ -229,6 +229,8 @@ void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type);
> >  unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
> >  int tpm2_probe(struct tpm_chip *chip);
> >  int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip);
> > +int tpm_find_and_validate_cc(struct tpm_chip *chip, struct tpm_space *space,
> > +                          const void *buf, size_t bufsiz);
> >  int tpm2_find_cc(struct tpm_chip *chip, u32 cc);
> >  int tpm2_init_space(struct tpm_space *space, unsigned int buf_size);
> >  void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space);
> > @@ -244,4 +246,23 @@ void tpm_bios_log_setup(struct tpm_chip *chip);
> >  void tpm_bios_log_teardown(struct tpm_chip *chip);
> >  int tpm_dev_common_init(void);
> >  void tpm_dev_common_exit(void);
> > +
> > +#ifdef CONFIG_TCG_TPM_RESTRICT_PCR
> > +#define TPM_RESTRICTED_PCR 23
> > +
> > +int tpm1_cmd_restricted(struct tpm_chip *chip, u8 *buffer, size_t size);
> > +int tpm2_cmd_restricted(struct tpm_chip *chip, u8 *buffer, size_t size);
> > +#else
> > +static inline int tpm1_cmd_restricted(struct tpm_chip *chip, u8 *buffer,
> > +                                   size_t size)
> > +{
> > +     return 0;
> > +}
> > +
> > +static inline int tpm2_cmd_restricted(struct tpm_chip *chip, u8 *buffer,
> > +                                   size_t size)
> > +{
> > +     return 0;
> > +}
> > +#endif
> >  #endif
> > diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> > index 8ec743dec26544..318e75ae42fb85 100644
> > --- a/drivers/char/tpm/tpm1-cmd.c
> > +++ b/drivers/char/tpm/tpm1-cmd.c
> > @@ -845,3 +845,38 @@ int tpm1_get_pcr_allocation(struct tpm_chip *chip)
> >
> >       return 0;
> >  }
> > +
> > +#ifdef CONFIG_TCG_TPM_RESTRICT_PCR
> > +int tpm1_cmd_restricted(struct tpm_chip *chip, u8 *buffer, size_t size)
> > +{
> > +     struct tpm_header *header = (struct tpm_header *)buffer;
> > +     char len, offset;
> > +     __be32 *pcr;
> > +     int pos;
> > +
> > +     switch (be32_to_cpu(header->ordinal)) {
> > +     case TPM_ORD_PCR_EXTEND:
> > +             if (size < (TPM_HEADER_SIZE + sizeof(u32)))
> > +                     return -EINVAL;
> > +             pcr = (__be32 *)&buffer[TPM_HEADER_SIZE];
> > +             if (be32_to_cpu(*pcr) == TPM_RESTRICTED_PCR)
> > +                     return -EPERM;
> > +             break;
> > +     case TPM_ORD_PCR_RESET:
> > +             if (size < (TPM_HEADER_SIZE + 1))
> > +                     return -EINVAL;
> > +             len = buffer[TPM_HEADER_SIZE];
> > +             if (size < (TPM_HEADER_SIZE + 1 + len))
> > +                     return -EINVAL;
> > +             offset = TPM_RESTRICTED_PCR/3;
> > +             if (len < offset)
> > +                     break;
> > +             pos = TPM_HEADER_SIZE + 1 + offset;
> > +             if (buffer[pos] & (1 << (TPM_RESTRICTED_PCR - 2 * offset)))
> > +                     return -EPERM;
> > +             break;
> > +     }
> > +
> > +     return 0;
> > +}
> > +#endif
> > diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> > index 69126a6770386e..dbf7f5552c6782 100644
> > --- a/drivers/char/tpm/tpm2-cmd.c
> > +++ b/drivers/char/tpm/tpm2-cmd.c
> > @@ -821,3 +821,25 @@ int tpm2_find_cc(struct tpm_chip *chip, u32 cc)
> >
> >       return -1;
> >  }
> > +
> > +#ifdef CONFIG_TCG_TPM_RESTRICT_PCR
> > +int tpm2_cmd_restricted(struct tpm_chip *chip, u8 *buffer, size_t size)
> > +{
> > +     int cc = tpm_find_and_validate_cc(chip, NULL, buffer, size);
> > +     __be32 *handle;
> > +
> > +     switch (cc) {
> > +     case TPM2_CC_PCR_EXTEND:
> > +     case TPM2_CC_PCR_RESET:
> > +             if (size < (TPM_HEADER_SIZE + sizeof(u32)))
> > +                     return -EINVAL;
> > +
> > +             handle = (__be32 *)&buffer[TPM_HEADER_SIZE];
> > +             if (be32_to_cpu(*handle) == TPM_RESTRICTED_PCR)
> > +                     return -EPERM;
> > +             break;
> > +     }
> > +
> > +     return 0;
> > +}
> > +#endif
> > diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
> > index ffb35f0154c16c..6f51cd92c6400f 100644
> > --- a/drivers/char/tpm/tpm2-space.c
> > +++ b/drivers/char/tpm/tpm2-space.c
> > @@ -262,7 +262,7 @@ static int tpm2_map_command(struct tpm_chip *chip, u32 cc, u8 *cmd)
> >       return 0;
> >  }
> >
> > -static int tpm_find_and_validate_cc(struct tpm_chip *chip,
> > +int tpm_find_and_validate_cc(struct tpm_chip *chip,
> >                                   struct tpm_space *space,
> >                                   const void *cmd, size_t len)
>
> Split the export to a separate commit.

Will do all these, thanks for taking a look.
