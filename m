Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F944DB80C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 19:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345276AbiCPSoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 14:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235282AbiCPSoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 14:44:04 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC8CF46;
        Wed, 16 Mar 2022 11:42:49 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-2e58e59d101so33395727b3.13;
        Wed, 16 Mar 2022 11:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oTXwl/h5QuWRzMBi0zP+c+SB1YrB36aG9ZfpjqtT29U=;
        b=J0w7I8kHmhchIcf7JLHPMW8fRSicYFq7GaV2QZFkuZjdoH1RU1RnI40IW84Y49PLEA
         wvYHAOEKLTycLeVbqbIRE2WDZaKYVFtuT6+6pIYh3lz5/wTsJqmWL7nQVyivthskymAj
         dRPpWKTkH98eZgHrljesQ1m9p37PVup7ueh3gOV+0b3fdt5/MZ3qfyEuZ8y7O5T/vs0N
         SwZ1eTg/vOp2Q+yeo9Imz+eAGPvTIHQZhQ3tDEhnuNBtd7Mz9cf0ILVRS+YBJh5UO7EG
         eC83B2zpWjAja2zJ3s0c34o80VdVdggSxhtO2Hq6rCiLeeFdvDbtHwK5G+GrfC2yam33
         noSA==
X-Gm-Message-State: AOAM533Ppsgxs8VCauSQL/GQ6vcSnsFLpyfVskDdCJd40aqFc7P2nWvf
        KL86qmc5KyLNuI9FBIiLzIURsxaDsqlkTFxQgLg=
X-Google-Smtp-Source: ABdhPJyOMzZ9ALdW7cIKcFzgoUDQlFAyirIPFfErg8GEYS3dLevoVziwuCl0PReLxfIBUhgI7/akmPVZ7NgIZsli9n4=
X-Received: by 2002:a81:bd0:0:b0:2dc:184b:e936 with SMTP id
 199-20020a810bd0000000b002dc184be936mr1663717ywl.7.1647456168267; Wed, 16 Mar
 2022 11:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220314220937.939897-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20220314220937.939897-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 16 Mar 2022 19:42:37 +0100
Message-ID: <CAJZ5v0g7ZuY9_6zz6KP7+zhxDb99mdbQULhyNdHOy+Vi19FYtg@mail.gmail.com>
Subject: Re: [PATCH v2] thermal: int340x: Update OS policy capability
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 11:09 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Update the firmware with OS supported policies mask, so that firmware can
> relinquish its internal controls. Without this update several Tiger Lake
> laptops gets performance limited with in few seconds of executing in
> turbo region.
>
> The existing way of enumerating firmware policies via IDSP method and
> selecting policy by directly writing those policy UUIDS via _OSC method
> is not supported in newer generation of hardware.
>
> There is a new UUID "B23BA85D-C8B7-3542-88DE-8DE2FFCFD698" is defined for
> updating policy capabilities. As part of ACPI _OSC method:
>
> Arg0 - UUID: B23BA85D-C8B7-3542-88DE-8DE2FFCFD698
> Arg1 - Rev ID: 1
> Arg2 - Count: 2
> Arg3 - Capability buffers: Array of Arg2 DWORDS
>
> DWORD1: As defined in the ACPI 5.0 Specification
> - Bit 0: Query Flag
> - Bits 1-3: Always 0
> - Bits 4-31: Reserved
>
> DWORD2 and beyond:
> - Bit0: set to 1 to indicate Intel(R) Dynamic Tuning is active, 0 to
> indicate it is disabled and legacy thermal mechanism should
> be enabled.
> - Bit1: set to 1 to indicate Intel(R) Dynamic Tuning is controlling
> active cooling, 0 to indicate bios shall enable legacy thermal
> zone with active trip point.
> - Bit2: set to 1 to indicate Intel(R) Dynamic Tuning is controlling
> passive cooling, 0 to indicate bios shall enable legacy thermal
> zone with passive trip point.
> - Bit3: set to 1 to indicate Intel(R) Dynamic Tuning is handling
> critical trip point, 0 to indicate bios shall enable legacy
> thermal zone with critical trip point.
> - Bits 4:31: Reserved
>
> From sysfs interface, there is an existing interface to update policy
> UUID using attribute "current_uuid". User space can write the same UUID
> for ACTIVE, PASSIVE and CRITICAL policy. Driver converts these UUIDs to
> DWORD2 Bit 1 to Bit 3. When any of the policy is activated by user
> space it is assumed that dynamic tuning is active.
>
> For example
> $cd /sys/bus/platform/devices/INTC1040:00/uuids
> To support active policy
> $echo "3A95C389-E4B8-4629-A526-C52C88626BAE" > current_uuid
> To support passive policy
> $echo "42A441D6-AE6A-462b-A84B-4A8CE79027D3" > current_uuid
> To support critical policy
> $echo "97C68AE7-15FA-499c-B8C9-5DA81D606E0A" > current_uuid
>
> To check all the supported policies
> $cat current_uuid
> 3A95C389-E4B8-4629-A526-C52C88626BAE
> 42A441D6-AE6A-462b-A84B-4A8CE79027D3
> 97C68AE7-15FA-499c-B8C9-5DA81D606E0A
>
> To match the bit format for DWORD2, rearranged enum int3400_thermal_uuid
> and int3400_thermal_uuids[] by swapping current INT3400_THERMAL_ACTIVE
> and INT3400_THERMAL_PASSIVE_1.
>
> If the policies are enumerated via IDSP method then legacy method is
> used, if not the new method is used to update policy support.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Applied as 5.18 material, thanks!

> ---
> v2
> - Changed u16 to u32 for better alignment as suggested by David
>
>  .../intel/int340x_thermal/int3400_thermal.c   | 146 ++++++++++++------
>  1 file changed, 97 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> index 348b1f4ef801..b06a70fc6c18 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> @@ -17,8 +17,8 @@
>  #define INT3400_KEEP_ALIVE 0xA0
>
>  enum int3400_thermal_uuid {
> +       INT3400_THERMAL_ACTIVE = 0,
>         INT3400_THERMAL_PASSIVE_1,
> -       INT3400_THERMAL_ACTIVE,
>         INT3400_THERMAL_CRITICAL,
>         INT3400_THERMAL_ADAPTIVE_PERFORMANCE,
>         INT3400_THERMAL_EMERGENCY_CALL_MODE,
> @@ -31,8 +31,8 @@ enum int3400_thermal_uuid {
>  };
>
>  static char *int3400_thermal_uuids[INT3400_THERMAL_MAXIMUM_UUID] = {
> -       "42A441D6-AE6A-462b-A84B-4A8CE79027D3",
>         "3A95C389-E4B8-4629-A526-C52C88626BAE",
> +       "42A441D6-AE6A-462b-A84B-4A8CE79027D3",
>         "97C68AE7-15FA-499c-B8C9-5DA81D606E0A",
>         "63BE270F-1C11-48FD-A6F7-3AF253FF3E2D",
>         "5349962F-71E6-431D-9AE8-0A635B710AEE",
> @@ -59,6 +59,7 @@ struct int3400_thermal_priv {
>         char *data_vault;
>         int odvp_count;
>         int *odvp;
> +       u32 os_uuid_mask;
>         struct odvp_attr *odvp_attrs;
>  };
>
> @@ -142,12 +143,55 @@ static ssize_t current_uuid_show(struct device *dev,
>                                  struct device_attribute *devattr, char *buf)
>  {
>         struct int3400_thermal_priv *priv = dev_get_drvdata(dev);
> +       int i, length = 0;
> +
> +       if (priv->current_uuid_index > 0)
> +               return sprintf(buf, "%s\n",
> +                              int3400_thermal_uuids[priv->current_uuid_index]);
> +
> +       for (i = 0; i <= INT3400_THERMAL_CRITICAL; i++) {
> +               if (priv->os_uuid_mask & BIT(i))
> +                       length += scnprintf(&buf[length],
> +                                           PAGE_SIZE - length,
> +                                           "%s\n",
> +                                           int3400_thermal_uuids[i]);
> +       }
>
> -       if (priv->current_uuid_index == -1)
> -               return sprintf(buf, "INVALID\n");
> +       if (length)
> +               return length;
>
> -       return sprintf(buf, "%s\n",
> -                      int3400_thermal_uuids[priv->current_uuid_index]);
> +       return sprintf(buf, "INVALID\n");
> +}
> +
> +static int int3400_thermal_run_osc(acpi_handle handle, char *uuid_str, int *enable)
> +{
> +       u32 ret, buf[2];
> +       acpi_status status;
> +       int result = 0;
> +       struct acpi_osc_context context = {
> +               .uuid_str = NULL,
> +               .rev = 1,
> +               .cap.length = 8,
> +       };
> +
> +       context.uuid_str = uuid_str;
> +
> +       buf[OSC_QUERY_DWORD] = 0;
> +       buf[OSC_SUPPORT_DWORD] = *enable;
> +
> +       context.cap.pointer = buf;
> +
> +       status = acpi_run_osc(handle, &context);
> +       if (ACPI_SUCCESS(status)) {
> +               ret = *((u32 *)(context.ret.pointer + 4));
> +               if (ret != *enable)
> +                       result = -EPERM;
> +       } else
> +               result = -EPERM;
> +
> +       kfree(context.ret.pointer);
> +
> +       return result;
>  }
>
>  static ssize_t current_uuid_store(struct device *dev,
> @@ -164,16 +208,47 @@ static ssize_t current_uuid_store(struct device *dev,
>                          * If we have a list of supported UUIDs, make sure
>                          * this one is supported.
>                          */
> -                       if (priv->uuid_bitmap &&
> -                           !(priv->uuid_bitmap & (1 << i)))
> +                       if (priv->uuid_bitmap & BIT(i)) {
> +                               priv->current_uuid_index = i;
> +                               return count;
> +                       }
> +
> +                       /*
> +                        * There is support of only 3 policies via the new
> +                        * _OSC to inform OS capability:
> +                        * INT3400_THERMAL_ACTIVE
> +                        * INT3400_THERMAL_PASSIVE_1
> +                        * INT3400_THERMAL_CRITICAL
> +                        */
> +
> +                       if (i > INT3400_THERMAL_CRITICAL)
>                                 return -EINVAL;
>
> -                       priv->current_uuid_index = i;
> -                       return count;
> +                       priv->os_uuid_mask |= BIT(i);
> +
> +                       break;
>                 }
>         }
>
> -       return -EINVAL;
> +       if (priv->os_uuid_mask) {
> +               int cap, ret;
> +
> +               /*
> +                * Capability bits:
> +                * Bit 0: set to 1 to indicate DPTF is active
> +                * Bi1 1: set to 1 to active cooling is supported by user space daemon
> +                * Bit 2: set to 1 to passive cooling is supported by user space daemon
> +                * Bit 3: set to 1 to critical trip is handled by user space daemon
> +                */
> +               cap = ((priv->os_uuid_mask << 1) | 0x01);
> +               ret = int3400_thermal_run_osc(priv->adev->handle,
> +                                             "b23ba85d-c8b7-3542-88de-8de2ffcfd698",
> +                                             &cap);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return count;
>  }
>
>  static DEVICE_ATTR_RW(current_uuid);
> @@ -236,41 +311,6 @@ static int int3400_thermal_get_uuids(struct int3400_thermal_priv *priv)
>         return result;
>  }
>
> -static int int3400_thermal_run_osc(acpi_handle handle,
> -                               enum int3400_thermal_uuid uuid, bool enable)
> -{
> -       u32 ret, buf[2];
> -       acpi_status status;
> -       int result = 0;
> -       struct acpi_osc_context context = {
> -               .uuid_str = NULL,
> -               .rev = 1,
> -               .cap.length = 8,
> -       };
> -
> -       if (uuid < 0 || uuid >= INT3400_THERMAL_MAXIMUM_UUID)
> -               return -EINVAL;
> -
> -       context.uuid_str = int3400_thermal_uuids[uuid];
> -
> -       buf[OSC_QUERY_DWORD] = 0;
> -       buf[OSC_SUPPORT_DWORD] = enable;
> -
> -       context.cap.pointer = buf;
> -
> -       status = acpi_run_osc(handle, &context);
> -       if (ACPI_SUCCESS(status)) {
> -               ret = *((u32 *)(context.ret.pointer + 4));
> -               if (ret != enable)
> -                       result = -EPERM;
> -       } else
> -               result = -EPERM;
> -
> -       kfree(context.ret.pointer);
> -
> -       return result;
> -}
> -
>  static ssize_t odvp_show(struct kobject *kobj, struct kobj_attribute *attr,
>                          char *buf)
>  {
> @@ -422,10 +462,18 @@ static int int3400_thermal_change_mode(struct thermal_zone_device *thermal,
>         if (!priv)
>                 return -EINVAL;
>
> -       if (mode != thermal->mode)
> +       if (mode != thermal->mode) {
> +               int enabled;
> +
> +               if (priv->current_uuid_index < 0 ||
> +                   priv->current_uuid_index >= INT3400_THERMAL_MAXIMUM_UUID)
> +                       return -EINVAL;
> +
> +               enabled = (mode == THERMAL_DEVICE_ENABLED);
>                 result = int3400_thermal_run_osc(priv->adev->handle,
> -                                               priv->current_uuid_index,
> -                                               mode == THERMAL_DEVICE_ENABLED);
> +                                                int3400_thermal_uuids[priv->current_uuid_index],
> +                                                &enabled);
> +       }
>
>
>         evaluate_odvp(priv);
> --
> 2.31.1
>
