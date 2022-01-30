Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8826C4A3738
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 16:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355419AbiA3PU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 10:20:58 -0500
Received: from mail-yb1-f178.google.com ([209.85.219.178]:40874 "EHLO
        mail-yb1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347323AbiA3PUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 10:20:51 -0500
Received: by mail-yb1-f178.google.com with SMTP id 23so33007292ybf.7;
        Sun, 30 Jan 2022 07:20:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B+sJwPFAgN3YNkQrqpXV+cKoPAui0xuyuLBRL1lcyp0=;
        b=x2uB4TK0kJN5cAvdccNzG6IQ3atK1U5FWVbFL/xKIrUN+hi1lLPR6h4upCX6mbPY6T
         bZ2Ik7ivy3kRtSpPSmokL8B69jF1LJuTGlrHphNkh0Cf0hDGw8OlYWYTH8iQN/RQMXAT
         020FfLaqspGozDN/9Wamg6sNUf+9SX/SzhpsImsG4R/C67Ep4UBO7Ho3iBZDY63EcfpQ
         If1D/4AaQLYzOoxN4nNQotEVxXGqr9740JvpOvvbE1RT/X2eP8GMFl8idtU9jyWgOB7k
         waJoo5hh9M+kjdb2P8V2Ypcs2Ds6yKRoF1PDHkt6zXHA/tkdYEK05KuBKF44M/A1gCbC
         Plbg==
X-Gm-Message-State: AOAM532dm7UzJo1FN0cFkNcnFpMXQOPSRlWcTfADgNTYpvg6mlm5nImD
        vXxzLM0QV93FdLZwKIkaoO7Kz6YRJmsQ3riESp7PWMyq
X-Google-Smtp-Source: ABdhPJx+jfYmUbSVI6ItMonBCnezGJ0sXNORp2HfgazmsxDO9BUb29Z8y8E5WjvwEXUd0h7rwUv/BB0ag0LddOQFUFQ=
X-Received: by 2002:a25:c102:: with SMTP id r2mr26957463ybf.330.1643556051078;
 Sun, 30 Jan 2022 07:20:51 -0800 (PST)
MIME-Version: 1.0
References: <20220127193454.12814-1-ricardo.neri-calderon@linux.intel.com> <20220127193454.12814-7-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20220127193454.12814-7-ricardo.neri-calderon@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 30 Jan 2022 16:20:40 +0100
Message-ID: <CAJZ5v0hbtmP6LHngWg0J47G2PwTxNwmjb=KMyz1zi1FM09cF8g@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] thermal: netlink: Add a new event to notify CPU
 capabilities change
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 8:33 PM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>
> Add a new netlink event to notify change in CPU capabilities in terms of
> performance and efficiency.
>
> Firmware may change CPU capabilities as a result of thermal events in the
> system or to account for changes in the TDP (thermal design power) level.
>
> This notification type will allow user space to avoid running workloads
> on certain CPUs or proactively adjust power limits to avoid future events.
>
> The netlink message consists of a nested attribute
> (THERMAL_GENL_ATTR_CPU_CAPABILITY) with three attributes:
>
>  * THERMAL_GENL_ATTR_CPU_CAPABILITY_ID (type u32):
>    -- logical CPU number
>  * THERMAL_GENL_ATTR_CPU_CAPABILITY_PERFORMANCE (type u32):
>    -- Scaled performance from 0-1023
>  * THERMAL_GENL_ATTR_CPU_CAPABILITY_EFFICIENCY (type u32):
>    -- Scaled efficiency from 0-1023
>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Aubrey Li <aubrey.li@linux.intel.com>
> Cc: Lukasz Luba <lukasz.luba@arm.com>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> Reviewed-by: Len Brown <len.brown@intel.com>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Daniel, Lukasz, if you have any comments or concerns regarding this
patch, please let me know.

> ---
> Changes since v4:
>   * Renamed struct cpu_capability as struct thermal_genl_cpu_caps.
>     (Rafael)
>   * Removed automatic variable ret from
>     thermal_genl_event_cpu_capability_change() and instead always return
>     -EMSGSIZE on error. (Rafael)
>
> Changes since v3:
>   * None
>
> Changes since v2:
>   * None
>
> Changes since v1:
>   * Reworded commit message.
>   * Reworded the members of struct cpu_capacity for clarity. (Lukasz)
>   * Defined the CPU capability attributes to be scaled in the [0, 1023]
>     interval. (Lukasz)
> ---
>  drivers/thermal/thermal_netlink.c | 53 +++++++++++++++++++++++++++++++
>  drivers/thermal/thermal_netlink.h | 14 ++++++++
>  include/uapi/linux/thermal.h      |  6 +++-
>  3 files changed, 72 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_netlink.c
> index a16dd4d5d710..7c97a091680e 100644
> --- a/drivers/thermal/thermal_netlink.c
> +++ b/drivers/thermal/thermal_netlink.c
> @@ -43,6 +43,11 @@ static const struct nla_policy thermal_genl_policy[THERMAL_GENL_ATTR_MAX + 1] =
>         [THERMAL_GENL_ATTR_CDEV_MAX_STATE]      = { .type = NLA_U32 },
>         [THERMAL_GENL_ATTR_CDEV_NAME]           = { .type = NLA_STRING,
>                                                     .len = THERMAL_NAME_LENGTH },
> +       /* CPU capabilities */
> +       [THERMAL_GENL_ATTR_CPU_CAPABILITY]              = { .type = NLA_NESTED },
> +       [THERMAL_GENL_ATTR_CPU_CAPABILITY_ID]           = { .type = NLA_U32 },
> +       [THERMAL_GENL_ATTR_CPU_CAPABILITY_PERFORMANCE]  = { .type = NLA_U32 },
> +       [THERMAL_GENL_ATTR_CPU_CAPABILITY_EFFICIENCY]   = { .type = NLA_U32 },
>  };
>
>  struct param {
> @@ -58,6 +63,8 @@ struct param {
>         int temp;
>         int cdev_state;
>         int cdev_max_state;
> +       struct thermal_genl_cpu_caps *cpu_capabilities;
> +       int cpu_capabilities_count;
>  };
>
>  typedef int (*cb_t)(struct param *);
> @@ -190,6 +197,42 @@ static int thermal_genl_event_gov_change(struct param *p)
>         return 0;
>  }
>
> +static int thermal_genl_event_cpu_capability_change(struct param *p)
> +{
> +       struct thermal_genl_cpu_caps *cpu_cap = p->cpu_capabilities;
> +       struct sk_buff *msg = p->msg;
> +       struct nlattr *start_cap;
> +       int i;
> +
> +       start_cap = nla_nest_start(msg, THERMAL_GENL_ATTR_CPU_CAPABILITY);
> +       if (!start_cap)
> +               return -EMSGSIZE;
> +
> +       for (i = 0; i < p->cpu_capabilities_count; ++i) {
> +               if (nla_put_u32(msg, THERMAL_GENL_ATTR_CPU_CAPABILITY_ID,
> +                               cpu_cap->cpu))
> +                       goto out_cancel_nest;
> +
> +               if (nla_put_u32(msg, THERMAL_GENL_ATTR_CPU_CAPABILITY_PERFORMANCE,
> +                               cpu_cap->performance))
> +                       goto out_cancel_nest;
> +
> +               if (nla_put_u32(msg, THERMAL_GENL_ATTR_CPU_CAPABILITY_EFFICIENCY,
> +                               cpu_cap->efficiency))
> +                       goto out_cancel_nest;
> +
> +               ++cpu_cap;
> +       }
> +
> +       nla_nest_end(msg, start_cap);
> +
> +       return 0;
> +out_cancel_nest:
> +       nla_nest_cancel(msg, start_cap);
> +
> +       return -EMSGSIZE;
> +}
> +
>  int thermal_genl_event_tz_delete(struct param *p)
>         __attribute__((alias("thermal_genl_event_tz")));
>
> @@ -219,6 +262,7 @@ static cb_t event_cb[] = {
>         [THERMAL_GENL_EVENT_CDEV_DELETE]        = thermal_genl_event_cdev_delete,
>         [THERMAL_GENL_EVENT_CDEV_STATE_UPDATE]  = thermal_genl_event_cdev_state_update,
>         [THERMAL_GENL_EVENT_TZ_GOV_CHANGE]      = thermal_genl_event_gov_change,
> +       [THERMAL_GENL_EVENT_CPU_CAPABILITY_CHANGE] = thermal_genl_event_cpu_capability_change,
>  };
>
>  /*
> @@ -356,6 +400,15 @@ int thermal_notify_tz_gov_change(int tz_id, const char *name)
>         return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_GOV_CHANGE, &p);
>  }
>
> +int thermal_genl_cpu_capability_event(int count,
> +                                     struct thermal_genl_cpu_caps *caps)
> +{
> +       struct param p = { .cpu_capabilities_count = count, .cpu_capabilities = caps };
> +
> +       return thermal_genl_send_event(THERMAL_GENL_EVENT_CPU_CAPABILITY_CHANGE, &p);
> +}
> +EXPORT_SYMBOL_GPL(thermal_genl_cpu_capability_event);
> +
>  /*************************** Command encoding ********************************/
>
>  static int __thermal_genl_cmd_tz_get_id(struct thermal_zone_device *tz,
> diff --git a/drivers/thermal/thermal_netlink.h b/drivers/thermal/thermal_netlink.h
> index e554f76291f4..04d1adbbc012 100644
> --- a/drivers/thermal/thermal_netlink.h
> +++ b/drivers/thermal/thermal_netlink.h
> @@ -4,6 +4,12 @@
>   *  Author: Daniel Lezcano <daniel.lezcano@linaro.org>
>   */
>
> +struct thermal_genl_cpu_caps {
> +       int cpu;
> +       int performance;
> +       int efficiency;
> +};
> +
>  /* Netlink notification function */
>  #ifdef CONFIG_THERMAL_NETLINK
>  int __init thermal_netlink_init(void);
> @@ -23,6 +29,8 @@ int thermal_notify_cdev_add(int cdev_id, const char *name, int max_state);
>  int thermal_notify_cdev_delete(int cdev_id);
>  int thermal_notify_tz_gov_change(int tz_id, const char *name);
>  int thermal_genl_sampling_temp(int id, int temp);
> +int thermal_genl_cpu_capability_event(int count,
> +                                     struct thermal_genl_cpu_caps *caps);
>  #else
>  static inline int thermal_netlink_init(void)
>  {
> @@ -101,4 +109,10 @@ static inline int thermal_genl_sampling_temp(int id, int temp)
>  {
>         return 0;
>  }
> +
> +static inline int thermal_genl_cpu_capability_event(int count, struct cpu_capability *caps)
> +{
> +       return 0;
> +}
> +
>  #endif /* CONFIG_THERMAL_NETLINK */
> diff --git a/include/uapi/linux/thermal.h b/include/uapi/linux/thermal.h
> index 9aa2fedfa309..fc78bf3aead7 100644
> --- a/include/uapi/linux/thermal.h
> +++ b/include/uapi/linux/thermal.h
> @@ -44,7 +44,10 @@ enum thermal_genl_attr {
>         THERMAL_GENL_ATTR_CDEV_MAX_STATE,
>         THERMAL_GENL_ATTR_CDEV_NAME,
>         THERMAL_GENL_ATTR_GOV_NAME,
> -
> +       THERMAL_GENL_ATTR_CPU_CAPABILITY,
> +       THERMAL_GENL_ATTR_CPU_CAPABILITY_ID,
> +       THERMAL_GENL_ATTR_CPU_CAPABILITY_PERFORMANCE,
> +       THERMAL_GENL_ATTR_CPU_CAPABILITY_EFFICIENCY,
>         __THERMAL_GENL_ATTR_MAX,
>  };
>  #define THERMAL_GENL_ATTR_MAX (__THERMAL_GENL_ATTR_MAX - 1)
> @@ -71,6 +74,7 @@ enum thermal_genl_event {
>         THERMAL_GENL_EVENT_CDEV_DELETE,         /* Cdev unbound */
>         THERMAL_GENL_EVENT_CDEV_STATE_UPDATE,   /* Cdev state updated */
>         THERMAL_GENL_EVENT_TZ_GOV_CHANGE,       /* Governor policy changed  */
> +       THERMAL_GENL_EVENT_CPU_CAPABILITY_CHANGE,       /* CPU capability changed */
>         __THERMAL_GENL_EVENT_MAX,
>  };
>  #define THERMAL_GENL_EVENT_MAX (__THERMAL_GENL_EVENT_MAX - 1)
> --
> 2.17.1
>
